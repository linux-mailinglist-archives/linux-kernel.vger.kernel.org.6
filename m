Return-Path: <linux-kernel+bounces-194757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB68D4188
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83BCB24810
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63081CB328;
	Wed, 29 May 2024 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc3W/NKE"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FFB225D6;
	Wed, 29 May 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022896; cv=none; b=PAZ+/p4Lgw8dkLEa35FjJFR94kklHX2Jfvm6ACZ6DSNCF4xUlboZkzVYXSrbvugkeb7vJ0vi7OUJXmSVy3VhkQuErlCoe0utSLfAWqWdZLPpiHitlpBesbm3ie7Gn+7svN6qHRZaS6i2wZS+8WfpyglBisSFWQQi+erNX+cdFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022896; c=relaxed/simple;
	bh=kIQxWCp4T/UjC55EzJJc7MoQhsZfA5hUe9Ve7PJCPc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLdIbLSIJpyjfu4t1eQApkiDcLQKyw6HmwkuTyQLIvzLuO4VFoZZLtjHRWX0fcH8omL9jykOgfxtZ3PJtR9rEcEbUQnmjY4FXrDS7XNBzIBHIig6JZQTrwTw29sB42Ul3eQl2TECQnB0HcXI9hv8nJQGvu/xb5TvK5KgeQLsEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc3W/NKE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2bf62b121ccso181135a91.0;
        Wed, 29 May 2024 15:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717022894; x=1717627694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABwI+mlNNanS+CXAFnI17TdX+7vx8X0eFIT1YLUdfwA=;
        b=Hc3W/NKEBC5tKjqCrVvjSclrF+CrgBRQDYIlzS56qAM6JxEZpHyiUmCuPKzhM9fSA9
         ZKnMv0/p4cWny9bkno4m21Q+wXdAlq0sl1bDVi8MXfkWKKD0EEfFequryPFnOq2YZLYj
         d2817pU0BjgSK22RPljzTCkXnH6w0M0+x7tBabWJ4HemE9D+neYkGFBfDQq6BWVNMG4m
         2dUy7UQG8Rzyr3hSKmEqsA3TvY1pGdMbWQCV2vDEgPL2XFOVqlJLu6GfLXCRKHvDgTJD
         i1tJvM66MNGPLDtvyslSCSeDjkZ3usunlAADH/5Ai5r9cE9Iy3N43JPaFA/vePj5Dwel
         A7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022894; x=1717627694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABwI+mlNNanS+CXAFnI17TdX+7vx8X0eFIT1YLUdfwA=;
        b=Xqbxb3G8TE22RxNz/oZOr22+NI1r7rPFlqf/E7EA8zSieLMXELkfmgz1PNAFZn/b02
         RqitgMV2uP+WBxrBpZ0aIW+DiexQiVoSsbuzI5JocDAuxC7YQ4YZk2MipBWry4dj5Zrl
         ACfi2RWpcltrB9cmWU6NC2tFxFFWQGyiUksAwfc3YiMVJQ0CMnM2issQaoXrBClSKaTG
         7mouGgL0wecKpCnxvSi4wJDMemWAHnvDmLcJJLGw5NAk6iWuw8MV0UzaS5gQqQawzIW3
         1ms+ekZZ2FiwjcxDPLo/k4ySzEcw/mYKkCidOQgBz/qLAxwGyfGIkzNhgf4YZfyERjv4
         crVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd385wnv6KT2JP/EwI1SU1xVvVmktvctWC8VmXf3paWS4RPz3P1V1wCJSQexKW8CBqQCasRtArqvu+SJeX9ul4zzRTGH4V3/yyATFF8G7pt2ZR3OnbhO1wyS6MstWClBZmkXSZTZBj/hEuI0834rNYvZo3mwtniDiNNS+hasq1S2i1pjvi
X-Gm-Message-State: AOJu0Yy5zxynIZnOgeyPUuJHy3fkaZanY/ZeO0PG0UO5qskPu9J1d623
	QomlTk8j4LrQUDrvfiu4n1jC9fNIn0dRTmqDn9lk7/VayGMGTMlJ
X-Google-Smtp-Source: AGHT+IFLvFtfztScCvZKyN1/Lb8xV97INLGc+Ne9r90Rgj+5btO1K9SZDv+j5+pwAYKpyg+SOzrYuw==
X-Received: by 2002:a17:90a:71c1:b0:2b4:bd38:7568 with SMTP id 98e67ed59e1d1-2c1acc2da71mr263392a91.5.1717022893485;
        Wed, 29 May 2024 15:48:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77ae97bsm342616a91.35.2024.05.29.15.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:48:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 May 2024 15:48:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: g762: Convert to yaml schema
Message-ID: <86fa6628-8390-4b7f-be55-47d883e5a753@roeck-us.net>
References: <20240526184526.21010-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526184526.21010-1-ansuelsmth@gmail.com>

On Sun, May 26, 2024 at 08:45:23PM +0200, Christian Marangi wrote:
> Convert g762 Documentation to yaml schema.
> 
> Since it supports various device, change the name to g76x and add the
> vendor prefix.

The file name should not change. This document does not cover g76[0,4-9],
after all.

Guenter

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/g762.txt        | 47 -----------
>  .../devicetree/bindings/hwmon/gmt,g76x.yaml   | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
> deleted file mode 100644
> index 6d154c4923de..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/g762.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -GMT G762/G763 PWM Fan controller
> -
> -Required node properties:
> -
> - - "compatible": must be either "gmt,g762" or "gmt,g763"
> - - "reg": I2C bus address of the device
> - - "clocks": a fixed clock providing input clock frequency
> -	     on CLK pin of the chip.
> -
> -Optional properties:
> -
> - - "fan_startv": fan startup voltage. Accepted values are 0, 1, 2 and 3.
> -	       The higher the more.
> -
> - - "pwm_polarity": pwm polarity. Accepted values are 0 (positive duty)
> -	       and 1 (negative duty).
> -
> - - "fan_gear_mode": fan gear mode. Supported values are 0, 1 and 2.
> -
> -If an optional property is not set in .dts file, then current value is kept
> -unmodified (e.g. u-boot installed value).
> -
> -Additional information on operational parameters for the device is available
> -in Documentation/hwmon/g762.rst. A detailed datasheet for the device is available
> -at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
> -
> -Example g762 node:
> -
> -   clocks {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -
> -	g762_clk: fixedclk {
> -		 compatible = "fixed-clock";
> -		 #clock-cells = <0>;
> -		 clock-frequency = <8192>;
> -	}
> -   }
> -
> -   g762: g762@3e {
> -	compatible = "gmt,g762";
> -	reg = <0x3e>;
> -	clocks = <&g762_clk>
> -	fan_gear_mode = <0>; /* chip default */
> -	fan_startv = <1>;    /* chip default */
> -	pwm_polarity = <0>;  /* chip default */
> -   };
> diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> new file mode 100644
> index 000000000000..bfefe49f54bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/gmt,g76x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GMT G762/G763 PWM Fan controller
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  GMT G762/G763 PWM Fan controller.
> +
> +  If an optional property is not set in DT, then current value is kept
> +  unmodified (e.g. bootloader installed value).
> +
> +  Additional information on operational parameters for the device is available
> +  in Documentation/hwmon/g762.rst. A detailed datasheet for the device is available
> +  at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - gmt,g762
> +      - gmt,g763
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: a fixed clock providing input clock frequency on CLK
> +      pin of the chip.
> +    maxItems: 1
> +
> +  fan_startv:
> +    description: Fan startup voltage step
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  pwm_polarity:
> +    description: PWM polarity (psotivie or negative duty)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  fan_gear_mode:
> +    description: FAN gear mode. Configure High speed fan setting factor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clocks {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        g762_clk: fixedclk {
> +            compatible = "fixed-clock";
> +            #clock-cells = <0>;
> +            clock-frequency = <8192>;
> +        };
> +    };
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        g762@3e {
> +            compatible = "gmt,g762";
> +            reg = <0x3e>;
> +            clocks = <&g762_clk>;
> +            fan_gear_mode = <0>;
> +            fan_startv = <1>;
> +            pwm_polarity = <0>;
> +        };
> +    };

