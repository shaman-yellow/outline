
isOk <- apply(data, 1,
  function(row) {
    if (any(row < 1500)) T
    else F
  })
res <- data[isOk, ]

