class ResponseError {
    String status;
    Results results;

    ResponseError({
       required this.status,
       required this.results,
    });

    factory ResponseError.fromJson(Map<String, dynamic> json) {
        if (!json.containsKey('status') || !json.containsKey('results')) {
            throw FormatException('Missing required key(s) in JSON');
        }
        return ResponseError(
            status: json["status"],
            results: Results.fromJson(json["results"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "results": results.toJson(),
    };
}

class Results {
    String message;
    String code;
    String invalidCategory;

    Results({
       required this.message,
       required this.code,
       required this.invalidCategory,
    });

    factory Results.fromJson(Map<String, dynamic> json) {
        if (!json.containsKey('message') || !json.containsKey('code') || !json.containsKey('invalid_category')) {
            throw FormatException('Missing required key(s) in JSON');
        }
        return Results(
            message: json["message"] ?? "Default error message", // Default jika null
            code: json["code"] ?? "Unknown code", // Default jika null
            invalidCategory: json["invalid_category"] ?? "Unknown category", // Default jika null
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "invalid_category": invalidCategory,
    };
}
