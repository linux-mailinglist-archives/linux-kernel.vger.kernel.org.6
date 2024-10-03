Return-Path: <linux-kernel+bounces-349175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51298F236
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1990828331A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFC41A0721;
	Thu,  3 Oct 2024 15:12:42 +0000 (UTC)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C917C224;
	Thu,  3 Oct 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968362; cv=none; b=eTbj6vl97PJvFdbHWOJ6Rjazev0D5sDArB/k56uJE6a+8IV6pNCJJE6KWXkuR95X/3Ooj1U5ru7aJXUXsytxOEzvqu8PHTED3XjUYQeKCC/G/HYSHQhKeuYg8pQ/Q9jGGRVVbmwdE/Vmma6ee43IvyIosP1F9yOKXIW2cVIjRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968362; c=relaxed/simple;
	bh=gwKW4ycAUTNy1tipNB505j/jZ3lNfe3SfserdHNQQkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwy6UWbk6M+Rsa+S5GhTK7+s+CO3Htaw5VRJzeM7FoCKyaY1/Ly5AnlTfvbko7QMzNC4yCAZadz2V/2vTAaRL1ewyPHWFy+/zg82/dTHY9xIow/ZxeA4W8CHCOCpTyllHiG9NwH4E76VmhsNe0mJKy/Ra6o1Tw4evZUHL0noLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a367da1f8cso4284565ab.2;
        Thu, 03 Oct 2024 08:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727968355; x=1728573155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47KD1hatbg94UjbGvu7DyHwu3QN5WNe4psfvAfpMbAE=;
        b=cbPLYk1lFMW7jq+V8ur3os+XP0MgSaqDNouxZozh6++/Zlpt4EuHi6M/H0e70ktzF6
         b7OwVnRtnGgor0Mgv4Km6kdod3yHJb1wtyOipvqhqu/22jvDb3fp258a78Cy7JoinKTm
         WvB0DtwjVBbvkZTUjGXBiedly36XSGQOsH2FCZxImxg/32jPDyBHnGeo/iaoVp0iaUnv
         elMIjewctpL2QfLGBViVwpXuh8K7b81uYn1jLAXClOYA5rt6m74AEUTYJW8ehIoPe/Bu
         1x3Zmw4jfvU5qmDj6sWpfR5hsrSvc+HcVK7SLRYX7/aLIgcB3ZJyybMgFfhj4JBoTFzm
         33lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+S3fWe4DZyiLQATdJBunlS9TlD4nLrQOu/8+9FOFwSwLuomddCadNMOTayxWN9Ovw4KL0zpjnVF3tfO+O@vger.kernel.org, AJvYcCWox1YoAnErMngfLbR7X+s08dkJ0EtL5+QtOlfLjSNtenN+RaSR58qzeVZtP8Zz62QR7OAnNya/A5jT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MUNY9t+ZJqmoZiVwJAuQfnI+uH5Lm3ECzrAoCICrAqCibm1t
	Z6XeydydF0R328HgR0seJMKMyF911M7RYnxUuY6t7FXxIBi6EqNPaMG47fnJ
X-Google-Smtp-Source: AGHT+IGLzNmfgEZNEVxJSuO/fIcVpvdtfZYWVFG3ozV7qrdfHwgdOBkjrTLK6ugR5pW+PKSINhwioQ==
X-Received: by 2002:a05:6e02:12e5:b0:3a0:9244:191d with SMTP id e9e14a558f8ab-3a365942fd5mr60489145ab.16.1727968354573;
        Thu, 03 Oct 2024 08:12:34 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55aa3784sm310131173.123.2024.10.03.08.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:12:31 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-834d3363a10so49601739f.1;
        Thu, 03 Oct 2024 08:12:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKREmqxfKSxfTVpkhM+Suap2dm1WNuCp5ezngJFC3TI4N3/r7RR7+Ja7cD7Kgj331mHCcG+EFujc1/Ehkt@vger.kernel.org, AJvYcCWtPbgjnnGFz8ewTeh97YMXQS5nT/+C6sdQ94lwiErSi0JmDWciaSP1D045Q0qB40N3DvI884+nfGqL@vger.kernel.org
X-Received: by 2002:a05:6602:634e:b0:806:31ee:132 with SMTP id
 ca18e2360f4ac-834d83f7467mr701739239f.4.1727968351148; Thu, 03 Oct 2024
 08:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003111444.543964-1-andre.przywara@arm.com> <20241003111444.543964-2-andre.przywara@arm.com>
In-Reply-To: <20241003111444.543964-2-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Oct 2024 23:12:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v65vx+9gD41yK_gcBSk2_GQKLxn1O806RJ9HpMqMA1gDAQ@mail.gmail.com>
Message-ID: <CAGb2v65vx+9gD41yK_gcBSk2_GQKLxn1O806RJ9HpMqMA1gDAQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: mfd: x-powers,axp152: Document AXP323
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Martin Botka <martin.botka@somainline.org>, Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 7:15=E2=80=AFPM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> The X-Powers AXP323 is a PMIC used on some newer Allwinner devices.
> It is almost the same as the AXP313, but supports dual-phasing the first
> two DC/DC converters. A pure AXP313 driver wouldn't know about this, and
> might turn the linked DCDC2 regulator off, as it does not seem to be
> used. This makes the AXP323 incompatible to the AXP313a.
>
> Add the new compatible string, and treat it like the AXP313a.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b=
/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> index 14ab367fc887..3f7661bdd202 100644
> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> @@ -71,6 +71,7 @@ allOf:
>                  - x-powers,axp15060
>                  - x-powers,axp305
>                  - x-powers,axp313a
> +                - x-powers,axp323
>
>      then:
>        required:
> @@ -82,6 +83,7 @@ allOf:
>            contains:
>              enum:
>                - x-powers,axp313a
> +              - x-powers,axp323
>                - x-powers,axp15060
>                - x-powers,axp717
>
> @@ -100,6 +102,7 @@ properties:
>            - x-powers,axp221
>            - x-powers,axp223
>            - x-powers,axp313a
> +          - x-powers,axp323
>            - x-powers,axp717
>            - x-powers,axp803
>            - x-powers,axp806
> --
> 2.25.1
>

