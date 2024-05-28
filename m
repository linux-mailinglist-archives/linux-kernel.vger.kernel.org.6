Return-Path: <linux-kernel+bounces-192736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432EB8D2172
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5691C238AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE7172BAD;
	Tue, 28 May 2024 16:17:14 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49E171E7F;
	Tue, 28 May 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913034; cv=none; b=hpwoJIUBS/2iXIg6MzZ66vmdV61/NngC9IANf3kJsHwJC86O+ZhGFaugA9BUSP850+eQtjiLETqCCpnybPSMhGgqbftfnM4cGcQY4OilHN3JJDvBZB7XMNfWN5UhrL9534qPhZMuvkFkWqgDZxefmYuPoK5X4Vditj6IaWjwh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913034; c=relaxed/simple;
	bh=ZJJp9PavHBfDU3cnxTSm/Kzg1wrKhwuBqR/5e+li/jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfdtZRu1WA7cmnbcaLqGFVl53/NGNvvl3r3pEKiFEww6DOcDMti+USTkC4bECXj7pPb20Dt/97nmE6ePTgPhQ6dw25BDWbON0YCK5NvNNGv/nf2mSnNSyhiFH2k+6Hjh3LwSgHuM0idsR/5Il7DFoUuCaPjz7FZdPIfh0ATP4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso10718471fa.2;
        Tue, 28 May 2024 09:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716913030; x=1717517830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POQOGQ5K3bE6qgJcC1wmgZLXFfBrxNj838TwyNFS0Ic=;
        b=D+YEFJYRH8X9vvdeBQ4TV/TebKJHR4zRc2/fK8wJdx0bXFE39iDthmgjfynObP+HxM
         OgCT4DK7NEZzpM60F16d8YC6HyzyiqRlGPgwkzkJRg9fM9Q67LZj5FcaBu6CLvaLoO4d
         1uB/jEPMtIqHplaeXdABtwMohmuQfwxOAK7NMQ+AL2Fvd2MjewKavw4uzhlMNzE6vUaZ
         qt7hUBpxWEIJQCGHuqYAO59Hqi+d/75MKhdbtRr2Uc5U38e13y3os8/iwT4RJVqNMdu/
         vrkvZzJmjS3gOK3SGVhLZniXXZVGFqKbg3i0IHmBss+bUezHnPBqQDliA/kyVsF48NP1
         dtwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKwvTDHmyyHdnD3FLbHzmvJ8gJ+iRgEnfgXFzLmAa++1vtWToCXiXSFmDucDXFbFxxuHLyb1ky4rt0fIcmb/SXujF6p1MCFu6mCotvEEVg1zB/fIC4CwsS/harjg9x0BCotS6yVMRPUQ==
X-Gm-Message-State: AOJu0YzsRww5yC/pR6rZt3SYqBH54HyIriSPY6y9RQHFbLdhtQDlJx6w
	zI5TzDe+TCh6x0xNnLxeDX/PHRl88KFfcHMe4iWru9zYorN3rjyRS6cqH6Xd
X-Google-Smtp-Source: AGHT+IED+9SzuuvngfeNtCXKgud3g+Vd8WrQBxQRSq9AwIvHAhmHSjreZI552BdYC1BSZDbIOPZMlg==
X-Received: by 2002:a05:651c:a09:b0:2e9:841d:dacb with SMTP id 38308e7fff4ca-2e9841dddeamr33875061fa.40.1716913029774;
        Tue, 28 May 2024 09:17:09 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc4ae2sm22530901fa.21.2024.05.28.09.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:17:09 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a883101so12572931fa.3;
        Tue, 28 May 2024 09:17:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+NlcsfktU4Ej0h3zeiuRdDfRbex2as/zfTZZqc5LubcPzlFAxZEoZS4tf2nAAUKECpY+HZ9M7qIklmU/U+rcfL+IIiDrG29XTsnntNg64qvi6Ox5ewyt0QnFTZqQgLM9fEgLGlRuCaA==
X-Received: by 2002:a05:651c:210:b0:2e9:852b:80d9 with SMTP id
 38308e7fff4ca-2e9852b8193mr23187971fa.8.1716913029436; Tue, 28 May 2024
 09:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <171691265249.683236.17741143131124450716.b4-ty@csie.org>
In-Reply-To: <171691265249.683236.17741143131124450716.b4-ty@csie.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 29 May 2024 00:16:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v66D=cn3jeK2OkfeJ52jyNSMe+244cO7AaTy64ritVVtJw@mail.gmail.com>
Message-ID: <CAGb2v66D=cn3jeK2OkfeJ52jyNSMe+244cO7AaTy64ritVVtJw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for A64
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:11=E2=80=AFAM Chen-Yu Tsai <wens@csie.org> wrote=
:
>
> On Sun, 28 Apr 2024 13:40:35 +0200, Dragan Simic wrote:
> > Add missing cache information to the Allwinner A64 SoC dtsi, to allow
> > the userspace, which includes lscpu(1) that uses the virtual files prov=
ided
> > by the kernel under the /sys/devices/system/cpu directory, to display t=
he
> > proper A64 cache information.
> >
> > While there, use a more self-descriptive label for the L2 cache node, w=
hich
> > also makes it more consistent with other SoC dtsi files.
> >
> > [...]
>
> Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!
>
> [1/1] arm64: dts: allwinner: Add cache information to the SoC dtsi for A6=
4
>       https://git.kernel.org/sunxi/linux/c/950c51e8ebb4

I had to do a quick rebase as the branch start point was incorrect. The
commit hashes will have changed. Rest assured that the patch is indeed
merged.


ChenYu

