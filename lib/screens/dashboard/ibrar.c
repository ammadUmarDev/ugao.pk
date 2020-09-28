
#define _CRT_SECURE_NO_DEPRECATE
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Declare constants
#define Decimal_places 4
#define average_count 9
#define empty_value " "
#define empty_cluster '#'
// Name of file that stores our raw data

char FILE_NAME[100] = " ";

// Data size
#define MAX_ROWS 20
#define MAX_COLUMNS 20

// Debug switch ('1' for debug ON, '0' for debug OFF)
#define DEBUG 1

//Functions
float roundValue(float value, int decimalPlaces)
{
    int magnitude = 1;
    for (int count = 0; count < decimalPlaces; count++)
    {
        magnitude = magnitude * 10;
    }
    value = round(value * magnitude - 0.5) / magnitude;
    return (value);
}
float RoundDown(float value, int decimal)
{
    int magnitude = 1;
    for (int count = 0; count < decimal; count++)
    {
        magnitude = magnitude * 10;
    }
    value = round(value * magnitude) / magnitude;
    return (value);
}

// Main entry point for the program
int main(void)
{
    //Welcome Message
    printf("Welcome To Assignment No:4\nIntroduction:\nNAME:EBIN SANTOST\nSTU.ID:218472101\n");
    // Decalred variables
    int rowIndex = 0;
    int columnIndex = 0;
    //To Store the Total
    float total = 0.0;
    //TO store the count during summary

    //To store the Count of 0 in Classification And Cluster Map
    int count0 = 0;
    //To store the Count of 1 in Classification And Cluster Map
    int count1 = 0;
    //To store the Count of -1 in Classification And Cluster Map
    int count2 = 0;
    //----------------------------------

    //To Store the total count for percentages in summary
    int totalcount = 0;
    //Check For loop condition in file reading
    int check = 0;
    // 2-dimensional array to store our raw data
    float rawData[MAX_ROWS][MAX_COLUMNS];
    //2D Matrix of Rounded_Data
    float roundedData[MAX_ROWS][MAX_COLUMNS];
    //2D Matrix of Average_Map
    float averageMap[MAX_ROWS][MAX_COLUMNS];
    //2D Matrix of Classification_Map
    int classificationMap[MAX_ROWS][MAX_COLUMNS];
    //2D Matrix of Cluster_Map
    int clusterMap[MAX_ROWS][MAX_COLUMNS];
    // Misc variables used for reading the data from the file
    float tempfloat = 0.0F;
    float tmp = 0.0F;
    char newline = ' ';

    // ----------------------------------------------------------------------
    //Initializing all arrays/matrix
    for (rowIndex = 0; rowIndex < MAX_ROWS; rowIndex++)
    {
        for (columnIndex = 0; columnIndex < MAX_COLUMNS; columnIndex++)
        {
            rawData[rowIndex][columnIndex] = -2;
            roundedData[rowIndex][columnIndex] = -2;
            averageMap[rowIndex][columnIndex] = -2;
            classificationMap[rowIndex][columnIndex] = -2;
            clusterMap[rowIndex][columnIndex] = -2;
        }
    }
    // Open the file for reading
    FILE *infp = NULL;
    while (check == 0)
    {
        printf("Please Enter The File Name To Process:\n");
        scanf("%s", FILE_NAME);
        infp = fopen(FILE_NAME, "r");
        // Check for errors and exit if found
        if (infp == NULL)
        {
            printf("Error: failed to open %s for reading Please enter a valid file name/path TryAgain!!.\n\n", FILE_NAME);
        }
        if (infp != NULL)
        {
            printf("File Opened Successfully\n");
            check = 1;
        }
    }

    // Read the file into the data structure
    for (rowIndex = 0; rowIndex < MAX_ROWS; rowIndex++)
    {
        // Read up until the last value
        for (columnIndex = 0; columnIndex < MAX_COLUMNS - 1; columnIndex++)
        {
            if (fscanf(infp, "%f,", &tempfloat) != EOF)
            {
                rawData[rowIndex][columnIndex] = tempfloat;
            }
            else
            {
                printf("Error: incorrect file format at row %d, col %d.\n", rowIndex + 1, columnIndex + 1);
                return (1);
            }
        }

        // Read the last value and the newline char
        if (fscanf(infp, "%f%c", &tempfloat, &newline) != EOF)
        {
            // Check if the last character in the line was a \n otherwise an error occured.
            //Xiao: I have added newline != '\n'
            if (newline != '\0' && newline != '\r' && newline != '\n')
            {
                printf("Error: incorrect file format at line %d. did not find a newline.\n", rowIndex + 1);
                return (1);
            }
            else
            {
                rawData[rowIndex][columnIndex] = tempfloat;
            }

            // Reset the character before the next read.
            newline = ' ';
        }
    }
    // ----------------------------------------------------------------------
    //---------------Printing Raw Data-----------------------

    printf("\n-------- RAW DATA ------\n\n");
    for (rowIndex = 0; rowIndex < MAX_ROWS; rowIndex++)
    {
        // Read up until the last value
        for (columnIndex = 0; columnIndex < MAX_COLUMNS; columnIndex++)
        {
            printf("%f ", rawData[rowIndex][columnIndex]);
        }

        printf("\n");
    }

    //--------------------------Rounding Data------------------------

    for (rowIndex = 0; rowIndex < MAX_ROWS; rowIndex++)
    {
        for (columnIndex = 0; columnIndex < MAX_COLUMNS; columnIndex++)
        {
            roundedData[rowIndex][columnIndex] = roundValue(rawData[rowIndex][columnIndex], 4);
        }
    }

    //------------------Printing Rounded Data------------------

    printf("\n----------- ROUNDED DATA---------\n\n");
    for (rowIndex = 0; rowIndex < MAX_ROWS; rowIndex++)
    {
        for (columnIndex = 0; columnIndex < MAX_COLUMNS; columnIndex++)
        {
            if (roundedData[rowIndex][columnIndex] == -2)
            {
                printf(empty_value);
            }
            else
            {
                printf("%.4f ", roundedData[rowIndex][columnIndex]);
            }
        }
        printf("\n");
    }
    //-------------------------------------------------

    //---------------------------Average Map---------------------

    for (rowIndex = 1; rowIndex < MAX_ROWS - 1; rowIndex++)
    {
        for (columnIndex = 1; columnIndex < MAX_COLUMNS - 1; columnIndex++)
        {
            total = 0.0;
            //Top Row
            total = total + roundedData[rowIndex - 1][columnIndex - 1];
            total = total + roundedData[rowIndex - 1][columnIndex];
            total = total + roundedData[rowIndex - 1][columnIndex + 1];
            //Middle Row
            total = total + roundedData[rowIndex][columnIndex - 1];
            total = total + roundedData[rowIndex][columnIndex];
            total = total + roundedData[rowIndex][columnIndex + 1];
            //Bottom Row
            total = total + roundedData[rowIndex + 1][columnIndex - 1];
            total = total + roundedData[rowIndex + 1][columnIndex];
            total = total + roundedData[rowIndex + 1][columnIndex + 1];
            if (total != 0)
            {
                averageMap[rowIndex][columnIndex] = RoundDown(total / average_count, 4);
            }
        }
    }

    //-----------------Printing Average Map------------------

    printf("\n");
    printf("-------------AVERAGE MAP----------\n");
    for (rowIndex = 0; rowIndex < MAX_ROWS; rowIndex++)
    {
        for (columnIndex = 0; columnIndex < MAX_COLUMNS; columnIndex++)
        {
            if (averageMap[rowIndex][columnIndex] == -2)
            {
                printf(empty_value);
            }
            else
            {
                printf("%.4f ", averageMap[rowIndex][columnIndex]);
            }
        }
        printf("\n");
    }
    //----------------------------------------------------------

    //-------------------------Classification_Map--------------

    for (rowIndex = 1; rowIndex < MAX_ROWS - 1; rowIndex++)
    {
        for (columnIndex = 1; columnIndex < MAX_COLUMNS - 1; columnIndex++)
        {
            //Check for 1
            if (roundedData[rowIndex][columnIndex] > averageMap[rowIndex][columnIndex])
            {
                classificationMap[rowIndex][columnIndex] = 1;
            }
            //Check for 0
            if (roundedData[rowIndex][columnIndex] == averageMap[rowIndex][columnIndex])
            {
                classificationMap[rowIndex][columnIndex] = 0;
            }
            //Check for -1
            if (roundedData[rowIndex][columnIndex] < averageMap[rowIndex][columnIndex])
            {
                classificationMap[rowIndex][columnIndex] = -1;
            }
        }
    }

    //---------------------Printing Classififcation Map------------

    printf("---------CLASSIFICATION MAP-----------\n");
    for (rowIndex = 0; rowIndex < MAX_ROWS; rowIndex++)
    {
        for (columnIndex = 0; columnIndex < MAX_COLUMNS; columnIndex++)
        {
            if (classificationMap[rowIndex][columnIndex] == -2)
            {
                printf(empty_value);
            }
            else
            {
                printf("%d ", classificationMap[rowIndex][columnIndex]);
            }
        }
        printf("\n");
    }
    //-------------------------------------------------

    //----------------------Cluster Map------------------

    for (rowIndex = 1; rowIndex < MAX_ROWS - 1; rowIndex++)
    {
        for (columnIndex = 1; columnIndex < MAX_COLUMNS - 1; columnIndex++)
        {
            //1 Value Cluster Check

            if (classificationMap[rowIndex][columnIndex] == 1 && classificationMap[rowIndex][columnIndex + 1] == 1 && classificationMap[rowIndex + 1][columnIndex] == 1 && classificationMap[rowIndex + 1][columnIndex + 1] == 1)
            {
                clusterMap[rowIndex][columnIndex] = 1;
            }
            //-1 Value Cluster Check

            else if (classificationMap[rowIndex][columnIndex] == -1 && classificationMap[rowIndex][columnIndex + 1] == -1 && classificationMap[rowIndex + 1][columnIndex] == -1 && classificationMap[rowIndex + 1][columnIndex + 1] == -1)
            {
                clusterMap[rowIndex][columnIndex] = -1;
            }
            //0 Value Cluster Check

            else if (classificationMap[rowIndex][columnIndex] == 0 && classificationMap[rowIndex][columnIndex + 1] == 0 && classificationMap[rowIndex + 1][columnIndex] == 0 && classificationMap[rowIndex + 1][columnIndex + 1] == 0)
            {
                clusterMap[rowIndex][columnIndex] = 0;
            }
            else
            {
                clusterMap[rowIndex][columnIndex] = empty_cluster;
            }
        }
    }

    //-----------------Printing Cluster Map----------------

    printf("\n");
    printf("----------- CLUSTER MAP------------\n");
    for (rowIndex = 0; rowIndex < MAX_ROWS; rowIndex++)
    {
        for (columnIndex = 0; columnIndex < MAX_COLUMNS; columnIndex++)
        {
            if (clusterMap[rowIndex][columnIndex] == -2)
            {
                printf(empty_value);
            }
            else
            {
                if (clusterMap[rowIndex][columnIndex] == empty_cluster)
                {
                    printf("%c ", clusterMap[rowIndex][columnIndex]);
                }
                else
                {
                    printf("%d ", clusterMap[rowIndex][columnIndex]);
                }
            }
        }
        printf("\n");
    }

    //------------------------------------------------------------------

    //-------------------------Summary-----------------------

    printf("-------------------- Summary -------------------\n");
    printf("Default Values:\n");
    printf("Rows:%d\n", MAX_ROWS);
    printf("Columns:%d\n", MAX_COLUMNS);
    printf("%c:", empty_cluster);
    printf("%d\n", 0);
    printf("Deciaml:%d\n\n", Decimal_places);

    //------------------Classification Map Summary----------------------

    for (rowIndex = 1; rowIndex < MAX_ROWS - 1; rowIndex++)
    {
        for (columnIndex = 1; columnIndex < MAX_COLUMNS - 1; columnIndex++)
        {
            if (classificationMap[rowIndex][columnIndex] == 1)
            {
                count1 += 1;
            }
            if (classificationMap[rowIndex][columnIndex] == 0)
            {
                count0 += 1;
            }
            if (classificationMap[rowIndex][columnIndex] == -1)
            {
                count2 += 1;
            }
        }
    }
    totalcount = count1 + count0 + count2;
    printf("Classification_Map_Summary:\n\n");
    printf("Symbol Counts %%\n");
    printf("-1     %d", count2);
    printf("    %d%%\n", (count2 * 100) / totalcount);
    printf(" 0     %d", count0);
    printf("      %d%%\n", (count0 * 100) / totalcount);
    printf(" 1     %d", count1);
    printf("    %d%%\n", (count1 * 100) / totalcount);
    printf("Total  %d", totalcount);
    printf("    100%%\n");

    //------------------------------------------------------

    //------------Cluster Map Summary---------------------

    count0 = 0;
    count1 = 0;
    count2 = 0;
    for (rowIndex = 1; rowIndex < MAX_ROWS - 1; rowIndex++)
    {
        for (columnIndex = 1; columnIndex < MAX_COLUMNS - 1; columnIndex++)
        {
            if (clusterMap[rowIndex][columnIndex] == 1)
            {
                count1 += 1;
            }
            if (clusterMap[rowIndex][columnIndex] == 0)
            {
                count0 += 1;
            }
            if (clusterMap[rowIndex][columnIndex] == -1)
            {
                count2 += 1;
            }
        }
    }
    printf("\n");
    printf("Cluster_Map_Summary:\n\n");
    printf("Symbol Counts %%\n");
    printf("-1     %d", count2);
    printf("     %d%%\n", (count2 * 100) / totalcount);
    printf(" 0     %d", count0);
    printf("      %d%%\n", (count0 * 100) / totalcount);
    printf(" 1     %d", count1);
    printf("      %d%%\n", (count1 * 100) / totalcount);
    printf("Total  %d", count1 + count0 + count2);
    printf("     %.0f%%\n", (ceil(count1 + count0 + count2) / totalcount) * 100);

    // ---------------Exit------------------------------------

    return (0);
}