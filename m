Return-Path: <linux-kernel+bounces-192702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA48D20E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA25EB22DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115F171E4C;
	Tue, 28 May 2024 15:56:48 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1BF171672;
	Tue, 28 May 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911808; cv=none; b=MJ8W0zBDpfg3eB363S0/2SABg0jXxC5sM7/j8iwgzmlaBwWnjsrH8UQLX+zmgGgV9fqVNBfeYniIS7jIgZSzkwrsyU89NIzkNN8s8vk8qn+6O+a7DT6Pu4JSlgVSZFOyNKmQwhSXth2qDrh7C51FhxOC9W3+XhSvnlxqr/4EA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911808; c=relaxed/simple;
	bh=ysSgJke61ofzGTOSWNXuddZUCwyuvR4kJz+M8yt9lHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYp/V0d/Sb3pgv07Y7laBFLvRlA13XhJY+AyRkHR4WRLCPyCn2L9y7RkAYi/RNlR3wETY7f6Euypf0iC/lcD5qLmBEqBzTaLXQlIZiqs8Fex0ZaGUuisRnw9mQSkKBYP+5yXqaFYHEralQGmlTczCiJv4tKtQfrR8SrHpBqHHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-529597d77b4so1284936e87.0;
        Tue, 28 May 2024 08:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911804; x=1717516604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvZxaJF28iL5uKpQcCM7Mk+grk1BxPMDMrXsVUajEUM=;
        b=RQ0V4rDELj0HqzwBT7iRqyTfiv+1dQSCWTp5MIGD12ONQihhp84sXTMoZ+JoLmI23C
         t07LRWjyvFLp1usq7xDTQz4pYKMjwER8s64ChTMEs2L475vghdWuk9R8tBWYb7SNljIE
         6lFEAbVebLe1kTbHdVJlIU0Y01FYXEVJxqNyDamLbWA0lv7sAti2uHjIc4nqzYuNu+FM
         fnA5i0c2/+GxE2h3BVIpo3OPP0Ud5+4MW9sAnBdnBXi6/yoJsOprvNxjnRbXAA0sz98N
         wr5baPQErfgVSHsV6ZSTAoasIGZAZdrvnm9AL2WqTIJrfFmv+zTffQ9tzSqXc3bpV0XQ
         JpJw==
X-Forwarded-Encrypted: i=1; AJvYcCXpNgYyX4PL99b3/Hr37MJsHHKnAyDuUehOehjCZ/8nrknWsNGmCuCXH6CklKgjQwpSEpm6SaPoB7utZH48OsSzSxaMdC/55QN4nS+4kItmBDid7wr1a66HwcIgSoBUOfghMDyb8Zy6Jg==
X-Gm-Message-State: AOJu0Yx5Wyz90Nayg5TD7g1wwgf1jnZmgo0gGhn//9csqfa7bk4CiLAG
	w96SFo02nYoUFDgWLxGJvD0TTaG3bj/h6uqJjVooUM6hd6PPj80yUpvZ0ONR
X-Google-Smtp-Source: AGHT+IGCOX+RTRXTm34fkoHu4ucl4/nBu08Dw4YFcfi1caFDIr3Qjeas5gW0w91XqkCx1SdKKFTFEQ==
X-Received: by 2002:a05:6512:36c1:b0:51f:6132:2803 with SMTP id 2adb3069b0e04-529645e337cmr6457584e87.17.1716911803734;
        Tue, 28 May 2024 08:56:43 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529b259abf7sm541888e87.304.2024.05.28.08.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 08:56:43 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso9990161fa.2;
        Tue, 28 May 2024 08:56:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwFyNxSDs+VPtXKvLf4SeNYls+3gaQZ4npj6CW6xHyTn/Fh2N9+QZ7/jPBGRIWog9EjFhv7LbqMmJwhP2Ec2M2j7dJ0NheYMn2dTYoi5ab4VW+UFY5Y7prjOFCjZmRHmyVyDJi4YUjpg==
X-Received: by 2002:a2e:90d9:0:b0:2df:c2b:8c84 with SMTP id
 38308e7fff4ca-2e95b09452fmr76184881fa.1.1716911803445; Tue, 28 May 2024
 08:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org> <171691117471.681554.6744393893618279840.b4-ty@csie.org>
In-Reply-To: <171691117471.681554.6744393893618279840.b4-ty@csie.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 28 May 2024 23:56:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ETOtHxQf1D9n+c9bGivsRTC=O8swDru+2cX2UT=o0qw@mail.gmail.com>
Message-ID: <CAGb2v64ETOtHxQf1D9n+c9bGivsRTC=O8swDru+2cX2UT=o0qw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H6
To: Dragan Simic <dsimic@manjaro.org>
Cc: jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:46=E2=80=AFPM Chen-Yu Tsai <wens@csie.org> wrote=
:
>
> On Sun, 28 Apr 2024 13:40:36 +0200, Dragan Simic wrote:
> > Add missing cache information to the Allwinner H6 SoC dtsi, to allow
> > the userspace, which includes lscpu(1) that uses the virtual files prov=
ided
> > by the kernel under the /sys/devices/system/cpu directory, to display t=
he
> > proper H6 cache information.
> >
> > Adding the cache information to the H6 SoC dtsi also makes the followin=
g
> > warning message in the kernel log go away:
> >
> > [...]
>
> Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!
>
> [1/1] arm64: dts: allwinner: Add cache information to the SoC dtsi for H6
>       https://git.kernel.org/sunxi/linux/c/c8240e4b0fd2

OK, that's weird. Somehow b4 thought this patch was v2 of the A64 patch [1]=
.
Looks like they are threaded together because this patch has "In-Reply-To".

Please avoid it in the future.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-sunxi/6a772756c2c677dbdaaab4a2c71a358d8e4=
b27e9.1714304058.git.dsimic@manjaro.org/

