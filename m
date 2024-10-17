Return-Path: <linux-kernel+bounces-370347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCFC9A2B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBAAB22452
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E0C1DFDA5;
	Thu, 17 Oct 2024 17:50:03 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDC1D95BE;
	Thu, 17 Oct 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187403; cv=none; b=H3IrhXAvi2a7hKEFVr9mU3mu47fK0e8qxEVxDJsuBVvaKHCUoB73ALqewh/AdswrL15Jb4y8gnq/Q1tppHRN53oT/wgHmrwgnvmsp5VTwN4t3yp5UTDoigkKleSVuQYV599mBYblWAqXL4SO2piOzMwjTajNGUAzUVevv24m7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187403; c=relaxed/simple;
	bh=+Lf3iObRGR3MI/gTOD1+me3xCFYuOFP73NluVCrLeIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQJRz/Stow6mRVGn8aTSJqUc8t8dqMqh7juInpqz39aQqSt0KsTxaTP50c5vOQk4PuPJ0eAsXI+Rv5fM04QCbbCWBvo/A6HQxSRvLFX7zLnSKXYkTor+Att7B0istBFg9aF6bCwghBIZUorRsqTBInpCs2E4qZc3NeDpg5ecn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso148187466b.2;
        Thu, 17 Oct 2024 10:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187395; x=1729792195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCloPbF7r5yRjYTtM6i8/cVXSwmwXC9Un1r2ajxc5jk=;
        b=hzdOrfPAcEzJzd+pMtpdbKwxrY2HxeZ/KbInmd4bKnfGtQPn81V24pjiuMZWfq5pNR
         ApL4NfCFGBNheovITXQ/i02c18NKCweylGMNldv9vTY6GdT9tCMa+rH86SCmfmAycAED
         kVMdzE6wEPqTpzPyAYKbFjx/iarQl2KhgPjhZlJ9/NXIxMJ1w7oytNk4LKUfrtYvJvPB
         krMIsXD1EhGZlCnNGX15r/o8mtZW3tEc0fPPCHoyfvX6M2kMxPiTL9mLELlqDR+ZGGKX
         GBMeujNRqDgVdS86h35WitFUUDuixO2M203K+DP9A4aWuIlIBU8asTjRVpjOrzsmuGqf
         Bh4A==
X-Forwarded-Encrypted: i=1; AJvYcCU5uTZWlYPWF5oznZrv8NcpoZlx3/0P8BdvFcKi9T8k48Be4f+xLYPK28eic5E7Orq6030UZjgy8rBRHu4w@vger.kernel.org, AJvYcCUrJa1NaLFL5c2kSDkGEJDj4mp49K9k1HzlNYGI0+iuygt5R+ykxfO//ceQfr4yq1rKN0nXJX3svKDV@vger.kernel.org, AJvYcCVg1WsHJ7QCMwGfJPYtGu8vKI0hnBRXJqVQllfbtX7YzgbsEG+lYpRr1tuMeMR8ssvMQyMDCTttgHf15zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDG9vk5v7rNbvME8YDZjusnm1PU9JQOEPhaYsc7Z0ze+0cNcOc
	9VullHQEX3nloK/Sp5EhlJpX4I4go8ErOEnxZdJ1edq1jdMjht/D3Q7yRIiFsjE=
X-Google-Smtp-Source: AGHT+IElnYNAm6Alq76dH3mwyEPBunkxieKVgLJJ2B6bUWTU1AxwH9Q3R7OK90JWvtJpr96eZeTPXg==
X-Received: by 2002:a17:907:7243:b0:a9a:5b78:cddc with SMTP id a640c23a62f3a-a9a5b78ce2bmr280632766b.64.1729187394939;
        Thu, 17 Oct 2024 10:49:54 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298433a1sm315837566b.162.2024.10.17.10.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 10:49:54 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a4031f69fso171180866b.0;
        Thu, 17 Oct 2024 10:49:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTYNTHz2SGXzMafJOZYD7kIg0Zzseh9zq5/eBw/jqwjRXH5eK9qspnO37inqpYGZWCY4ch63b1I6y8@vger.kernel.org, AJvYcCVlfN9lxjqP8U7CkHOO2fh1S6jP0LnIfjvebBmhYmtz6IctE3ZSJ5/EXTt2L4mpsFO0tuxYer2KjZpbIcg=@vger.kernel.org, AJvYcCXQVuh50XRDNqqqkMR7JGhi0h21xq70WIw2vOM6anTe9RuXDa18xigISMfPezkEn5WyfwJ7y9qF5SRviXnp@vger.kernel.org
X-Received: by 2002:a17:907:f1ea:b0:a99:fc3d:7c76 with SMTP id
 a640c23a62f3a-a9a34e15a00mr754925366b.37.1729187393982; Thu, 17 Oct 2024
 10:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
In-Reply-To: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 17 Oct 2024 13:49:17 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9Oh2WOR7B-LrPOo6C30HH7ENisCKHvTm3MuKiBdswppQ@mail.gmail.com>
Message-ID: <CAEg-Je9Oh2WOR7B-LrPOo6C30HH7ENisCKHvTm3MuKiBdswppQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASoC: add CS42L84 codec driver
To: James Calligeros <jcalligeros99@gmail.com>
Cc: =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 6:42=E2=80=AFAM James Calligeros
<jcalligeros99@gmail.com> wrote:
>
> Hi all,
>
> This patch set adds a driver for the Cirrus Logic CS42L84 codec. This chi=
p
> is (so far) found only on Apple Silicon Macs. In keeping with proud Apple
> tradition, the CS42L84 is essentially just a CS42L42 with a different
> regmap and no publicly available datasheet. It may also be missing its
> parent's S/PDIF capabilities as none of Apple's devices support S/PDIF ou=
t,
> however this cannot be positively confirmed.
>
> This driver has lived in the downstream Asahi tree for quite a while now,
> and gained some refinements along the way. I have squashed most of these
> into the initial driver commit as they were small changes like tweaking
> msleep()s or filling out TLVs, but left seperate a larger change to
> tip/ring sense IRQ handling as it differs significantly from what is foun=
d
> in the CS42L42 driver.
>
> ---
> James Calligeros (1):
>       ASoC: cs42l84: leverage ring sense IRQs to correctly detect headset=
s
>
> Martin Povi=C5=A1er (2):
>       dt-bindings: sound: Add CS42L84 codec
>       ASoC: cs42l84: Add new codec driver
>
>  Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml |   60 +++++=
++
>  MAINTAINERS                                                 |    2 +
>  sound/soc/codecs/Kconfig                                    |    7 +
>  sound/soc/codecs/Makefile                                   |    2 +
>  sound/soc/codecs/cs42l84.c                                  | 1110 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/cs42l84.h                                  |  210 +++++=
++++++++++++++++++++
>  6 files changed, 1391 insertions(+)
> ---
> base-commit: 469819cc17368702a6f68cec2148f518d3f3679b
> change-id: 20241016-cs42l84-f38348d21c88
>
> Best regards,
> --
> James Calligeros <jcalligeros99@gmail.com>
>
>

Used and reviewed over multiple revisions in Fedora Asahi Remix. :)

Reviewed-by: Neal Gompa <neal@gompa.dev>



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

