Return-Path: <linux-kernel+bounces-271498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5981C944F18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8826B249D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E031B32BB;
	Thu,  1 Aug 2024 15:22:56 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA661B013F;
	Thu,  1 Aug 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525775; cv=none; b=ZpPSL1ixnTJ8z2zYJmh1j35y1MRr+PC5NIzyuFj/UD4KQIWMsG9messPoSC0iPV44p76rj60WXYf2roLYkjidK2NiJxvekqVHEotpaB/FvmUldK+MgJIUVDi8Og7M3tclaf/brPSyPeHAu8qkLZOkgPjJNT+HV2a4xCS2351U14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525775; c=relaxed/simple;
	bh=VEcaGB9JhrX6r2iLab6nrkJZCg4diAR5tkxJzfjgTjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWPFDdVGCjM2XhbsgJ4HeNv9QfTz+xKgILZgDrQhaMIKLTt0nc9j6CmdO7unsxQtZ2kVDaDaPwNVtjxxGWfDkc2pxOgB96z00zZkd9pd7VyJOvCKTV8SsbkRO+qzRNRyUMCXZrZBSM3yINC7/u0LL7J0hOSybDHghCITFrjGKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f03df8c8cdso23924791fa.1;
        Thu, 01 Aug 2024 08:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525769; x=1723130569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Utqgbq+ns727DDPMponi3tkeUNp+6Bq/5OauBcszmLI=;
        b=o4VHNKl+Sc3gdaXkYwtIg8WXLWoDolW7+3zP8worezHI69G8ZO3/bHpPtDEqdNC6hl
         Q2Lv37sIwEiaFknHsL8Dv+0TyOO+AUEBLVzi8J+t/tKPsiqACCt28EM+Moje9ID5NwuH
         791nC0CkcTI+w42PI3/jmOYXAgmMvFx0ifq9UMNfybuuAMKJSJL79Q1TdyS91G/DbpZ2
         R5o1GUfq74hO6q1NFKfKNw1DA5zBnE1TufhlKAiotzTlRHQkmOhd+jCDx+7CJrteBtvY
         CbqjEVqs1T/Wo8ipCtk63rB3yKfvStwJwlSyZY6+nWzzFbHiqTwvn+NG6tuvrw59kJjp
         QASA==
X-Forwarded-Encrypted: i=1; AJvYcCWt/bfDU82gI/cMR0MzILesvuISqY+kcTCU5dkiyVvBtfhL0P9odJD6IjUF1Vbo0f5P+3c2+zFYbxEom8oHWW1WfCSJNFY0TJTVR1JNo3QsWdIebrZbDcunbCZtup/QvysKeyGzNhDtTw==
X-Gm-Message-State: AOJu0YynKHe5pI01h3YGB9/axrslo3dnk+r8eUsLQFo8Am4yYVDRBrJ3
	GFy7JV86lPW5QdL7a7HwEn8P87c0OdH1a4AVAGTvBY6QBA+bvVhc1tjy43lq
X-Google-Smtp-Source: AGHT+IE/Z31TKRQPQFhGnNud62ztSo1QNtnYru3Igrehf+8MxYtQEwrXS24COuhCQmg94r+IuwRoGw==
X-Received: by 2002:a2e:30a:0:b0:2ef:2768:619d with SMTP id 38308e7fff4ca-2f15760846fmr5362081fa.5.1722525769076;
        Thu, 01 Aug 2024 08:22:49 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d04e166sm23867201fa.81.2024.08.01.08.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 08:22:48 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef25511ba9so17953161fa.0;
        Thu, 01 Aug 2024 08:22:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhToIU6Pvsn4t93HqHrZnZYtCkKuEtGoJ//RA61ZdiDH8DkqeKhe/8q7VHfuVxeOSZcYOW7X4z1b0EetMofHOykkhEnB1k8Rm1y7FGyfQiLwXTJAd46XK/+7kuxiuSkx30T/aazj3gGQ==
X-Received: by 2002:a2e:be07:0:b0:2ee:df8f:652d with SMTP id
 38308e7fff4ca-2f1576089fdmr8111941fa.2.1722525768415; Thu, 01 Aug 2024
 08:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418000736.24338-1-andre.przywara@arm.com>
In-Reply-To: <20240418000736.24338-1-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 1 Aug 2024 23:22:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v64DLez_FwH=Na=swQ30BdZa8JPaueFkM=ozjU56=f1DXQ@mail.gmail.com>
Message-ID: <CAGb2v64DLez_FwH=Na=swQ30BdZa8JPaueFkM=ozjU56=f1DXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Ryan Walklin <ryan@testtoast.com>, Chris Morgan <macroalpha82@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 18, 2024 at 8:07=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> This is v2 of the fixes to the AXP717 PMIC support series. Lee put the
> original patches in an immutable branch already, so these here go on top.
> Patch 1 is new in v2, and adds the IRQ status and acknowledge registers
> to the writable range. Thanks to Chris for pointing this out.
> Patch 2 contains fixes to the regulator descriptions: the LDOs had the
> wrong supply source, and two numbers were wrong. The datasheet describes
> the voltage ranges and register values differently from what our macros
> expect, in a way that literally begs for off-by-ones, so here you go.
> Also there is an actual wrong number in the datasheet, add a comment to
> document this.
> I don't know if that's still feasible, but those two patches would be a
> good candidate to squash into the patches that they fix.
>
> The other three patches add the "boost" regulator, which is meant to
> provide the 5V USB VBUS power when operating from the battery. It's the
> usual trinity of binding/mfd/regulator patches.
> Again this could be squashed into the respective patches from the
> original series, if people agree.
>
> Please have a look and test!
>
> Based on mfd/ib-mfd-regulator-6.10, as detailed below.
>
> Cheers,
> Andre
>
> Changelog v1 .. v2:
> - add tags
> - add patch to add missing IRQ ack register range
> - add comment to document bug in datasheet
>
> Andre Przywara (5):
>   mfd: axp20x: AXP717: Fix missing IRQ status registers range
>   regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones
>   dt-bindings: mfd: x-powers,axp152: add boost regulator
>   mfd: axp20x: AXP717: Add support for boost regulator
>   regulator: axp20x: AXP717: Add boost regulator

The latter three patches still haven't been merged.

Andre, can you resend them for Lee or Mark to merge? Otherwise I
can't take the RG35XXSP DT patches.


Thanks
ChenYu

>
>  .../bindings/mfd/x-powers,axp152.yaml         |  2 +-
>  drivers/mfd/axp20x.c                          |  3 ++
>  drivers/regulator/axp20x-regulator.c          | 37 ++++++++++++-------
>  include/linux/mfd/axp20x.h                    |  3 ++
>  4 files changed, 30 insertions(+), 15 deletions(-)
>
>
> base-commit: 4cece764965020c22cff7665b18a012006359095
> prerequisite-patch-id: 2b5fb10f68e0994071fc4c7dce73db7047c23220
> prerequisite-patch-id: 5d0735de888d155b2c1cdb814e852a5852a17ec7
> prerequisite-patch-id: 29c30894b4bf0b9e1e71de065cabbd842505e248
> prerequisite-patch-id: 0ab87cbf7362b6dc2d577d2264eb9574be47b5f6
> --
> 2.35.8
>

