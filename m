Return-Path: <linux-kernel+bounces-571600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D069FA6BF94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49C11890EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80822CBD0;
	Fri, 21 Mar 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="uGVAE8PB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C61E00B4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573773; cv=none; b=auEtt/IJHUGtnBn9l4TfALbTmt4YW/+Yu6sEnNufuq/bohkKgBGxKoL5bgMH0KOaumxdh26EG9uX6HXE17Qdp1ew06yGkFuFTWsP0vLwfyk4gNduVSKHyBEw9L0J1Cf+3CngRZFPQavCGkVMepnRIXcbrxDDpT1pnUIEmStTMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573773; c=relaxed/simple;
	bh=Qmq+IIeW7g+9CyCIBj9m9ESzvYm18bl+IM9u6txU21A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=neZnIBXiDPouQnL8WK60N9AUXaX3QtFx5ekHrPn1kbAqKT2NKiEu4CTVvbxh5EXLREgZVxuojv6YUmyIeg5qVlIGNNnm/NQ11xxcvjUjxX31Ol79yibTL4j3xBHj1x38ZVaF99/h9A021M0EdZhhHQcEO25A7OOnWH4lwTKnxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=uGVAE8PB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab78e6edb99so333976466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1742573769; x=1743178569; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltF0A24cHxopXYW1+MzGLMtAYxZ2JVfXqEYIh6iUalE=;
        b=uGVAE8PBGtIQNltl5ur9C2SCvBKHnGvJWqZVkx2fdW+Yw9VfyVb8d47R5lnI+EEe8P
         iF2a3m1+JYI5UgPh4dDWlzWQLgRR0fqmUT7pXaQO5PkCttrFZR29gEzU61ev9pL9NlzI
         TAF6k9k/WrM6OTuDnRpYK23Y+OoxfkE9EdcVYlbPIq2e+BhFXvG5idRF4+2q9mHgtCi3
         G9O5d5iKhVnQIVcu4/aDjldJUsBpmL0SVYgkiCgTObVahuyBQRX6HMPOKkK6dmU2NMBn
         qXc22r2qAtS5UvP/k22r9jdBBWr86Ryy4uXj091wr8Db7nR+WaqAnnFWypyZQLq6H+k9
         9OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573769; x=1743178569;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ltF0A24cHxopXYW1+MzGLMtAYxZ2JVfXqEYIh6iUalE=;
        b=XwXHZLwU0MEUtFmwu6Wu3DhWmkt5zW+Z/fsFdgVWk6bxnW2pP+leejWls+MED+4nv3
         bj/MHubRgz3CzaLuy0mVIsW0gKgcYhcMPLXzJOle+H0wzRZz8NTfl7Bs/hmkJPQtERMZ
         gUoRV/siUw0A/GNxFoZMQuRQ2aNvipROhZkRmtVXNWQJGfb/dsdXWiPtQzXYJyggMD3g
         JZrYREmOJCEmINsSw0zBoVCXZwfMoa2MewqEIQInMCv6TGmQ3NKaurPQSOYiJcxWrz5M
         lHFB2EJLgWPWlQwerdk7mWmuJdzSWcGldjwEvdlRkfBtzd/uqGe3TlKLVMo5I/P3WktF
         klBg==
X-Forwarded-Encrypted: i=1; AJvYcCVchVjmwi2BW6QeDbSvNRJtBTvMKiMEApnC8XNPJen01XHb3K5scTnMcUUpeWiNsMte+I4yNPUVV336Y0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+jmSG7tnwwS03ecfHJCZHPbez+d32N7lJlqLYeQ0TUcDPEAy
	EN8ry3k0SeM8QlhVy3cvG5o92CJ+7VraRQ8g2dW5FCkzOH0eCExcMt1dc7Ct4kw=
X-Gm-Gg: ASbGncvI6jL5wznxxoDk6QVFXqfEOKMYInT7EaWOkEOfNkJ3AxPiQUqutPbMhSDIuH/
	7YrZbLk12RiK+XZxr+thX0Noybc0nwIzUVPWPg+s6V9DE7+D3z3dCV3owySRueofeKH7MCbqSqa
	ysnPGgqNNUQyHA5CjvZml4CMQo9qwLFTrxDk9TUeXxVR6sscLMIclE85GRRgM4J5hZcoA+Wgcd5
	29pCd8RCGjf3MDy5lnHJaARoZp4fTHd6X1mE5tL9UF0DsrEf01sNLegXy4dvbYp5+rlb2UlDRCX
	QNFrNh7+kREcGhL77d+kF2mQ/95qb/Kch7ME8ylYDErI1ub4rdU3af4fQR6T6ahQmhxYmMR00J0
	qin2FAn1VKc1i2puj2OhfOdhp
X-Google-Smtp-Source: AGHT+IFmQRpczSkNyyOfrjuw6J3EmbsHDKfFAxtFhB+1mO1JwxQr4UBgvHRHJp6Da2DG5aHbMNCDNA==
X-Received: by 2002:a17:906:4795:b0:ac1:e6b9:57ce with SMTP id a640c23a62f3a-ac3f208ab90mr381700166b.7.1742573768555;
        Fri, 21 Mar 2025 09:16:08 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0dfe4esm1546076a12.73.2025.03.21.09.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 17:16:07 +0100
Message-Id: <D8M2UHJQ86Q5.2EKUIIDRE3P73@fairphone.com>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Taniya Das" <quic_tdas@quicinc.com>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] clk: qcom: Add video clock controller driver for
 SM6350
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250321-sm6350-videocc-v1-0-c5ce1f1483ee@fairphone.com>
 <20250321-sm6350-videocc-v1-2-c5ce1f1483ee@fairphone.com>
 <pzevgib37fgdupythk3mawmeuki6dflpw5bze4ujb6jcjvj7ar@jmjuzeabvq7y>
In-Reply-To: <pzevgib37fgdupythk3mawmeuki6dflpw5bze4ujb6jcjvj7ar@jmjuzeabvq7y>

On Fri Mar 21, 2025 at 4:55 PM CET, Dmitry Baryshkov wrote:
> On Fri, Mar 21, 2025 at 03:45:00PM +0100, Luca Weiss wrote:
>> From: Konrad Dybcio <konradybcio@kernel.org>
>>=20
>> Add support for the video clock controller found on SM6350 based
>> devices.
>>=20
>> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
>> Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  drivers/clk/qcom/Kconfig          |   9 +
>>  drivers/clk/qcom/Makefile         |   1 +
>>  drivers/clk/qcom/videocc-sm6350.c | 355 +++++++++++++++++++++++++++++++=
+++++++
>>  3 files changed, 365 insertions(+)
>>=20
>> +
>> +/* 600 MHz */
>> +static const struct alpha_pll_config video_pll0_config =3D {
>> +	.l =3D 0x1F,
>
> Nit: lowercase hex please. No need to repost just for the sake of this
> single line.

Sounds like there'll be a v2 anyways with dts changes, so I'll fix it!

Regards
Luca

>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
>
>> +	.alpha =3D 0x4000,
>> +	.config_ctl_val =3D 0x20485699,
>> +	.config_ctl_hi_val =3D 0x00002067,
>> +	.test_ctl_val =3D 0x40000000,
>> +	.test_ctl_hi_val =3D 0x00000002,
>> +	.user_ctl_val =3D 0x00000101,
>> +	.user_ctl_hi_val =3D 0x00004005,
>> +};
>> +
>>=20


