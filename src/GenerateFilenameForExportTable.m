function [fileName] = GenerateFilenameForExportTable(fileName)
% Function that generates the filename for the outputtable table.
%   The function checks if there is already a file with the filename
%   parametricCycleAnalysis. If so it appends a number at the end of the
%   filename to not override the existing one.

[fPath, fName, fExt] = fileparts(fileName);

if isempty(fExt)  % No '.xlsx' in FileName
    fExt     = '.xlsx';
    fileName = fullfile(fPath, [fName, fExt]);
end

if exist(fileName,'file')
    [fPath, fName, fExt] = fileparts(fileName);
    fDir = dir(fullfile(fPath, [fName,' (*)', fExt]));
    if isempty(fDir)
        fileName = fullfile(fPath, [fName,' (1)', fExt]);
    else
        pattern = "(" + digitsPattern + ")" + fExt;
        hasThePattern = endsWith(fDir.name, pattern);
        Extracted = extract(fDir(hasThePattern).name,pattern);
        num = max(cell2mat(cellfun(@(C) textscan(C,'(%d)') , Extracted,'UniformOutput',true)));
        num = num+1;
        fileName = fullfile(fPath, [fName,' (',num2str(num),')', fExt]);
    end
end
end

