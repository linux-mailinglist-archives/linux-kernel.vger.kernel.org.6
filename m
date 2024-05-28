Return-Path: <linux-kernel+bounces-192738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 300718D2178
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E63B233C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31327172BAB;
	Tue, 28 May 2024 16:18:11 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8973445;
	Tue, 28 May 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913090; cv=none; b=niKYXW+RWb+qgcmPrvsTUEJydbJqMNqfz2ekelR3sN2HD8syi1nD4WSEn6Y73/ChB1pq9XgljDnCFoBrY0ghb/1F7MnpbQx5JQKHFbZJeUr+u9p8/povor56jky63tNuSPb95elICL4pDG9+CH1gJZKhQHd7+cjg0xb32ac1vRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913090; c=relaxed/simple;
	bh=qI/O/I/DKZxbnPe7MGquyE2ged/XjP50eQvro7VPpYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k72nDGt7G5A7ciW2fJ8G7/e3A6njfu7Zdj9hwRFgED3w1HFOkRvg4d7152aGI0gbQZiWvaZYvSJ+qLTWBVglBOxEWXlQ3c4y2E7oQz204FLKKIT3lQvW8fzG9SCb8Pfq83WEBnWF85qNQ1w5plAjzLdXF2HNKxMRBY093IES4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e95a7545bdso10957201fa.2;
        Tue, 28 May 2024 09:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716913087; x=1717517887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+cf9wMPn9ILQsVI8cmlxBX9GAhWkPtp3uNOSYd5ZQQ=;
        b=AI6S/u3f+0qNZ7TFO9CWJjiF0aUFMBe0tnWJUD08oOMZm/KACbXPYw5V6GV4fxLcvd
         NB3UiuJ/sIK5dv0FfOeCXasLZJLv9+F73+o4tfh/QiRnSwfpBCPJMN3CXIeBqXdkJqr6
         lEdUHwCuRDJ98nLXulcc3gCVZWPn4E5Fd9XI0+jkQO9YBbdUYSXKAkBg6asTWai33hj7
         B4kxCGwrMIQ5eg9b8sul7j4VXApJknNE3fmtJ3ErsYtCpKNi/lKQ+RsrKTMqaQ1J5b68
         ETyJmmWVtxluUqh/M9pUtIvT9duc2CKV7hdnxURTXe8IbpD0a79tsBwabD2lP2cP7Gg7
         BWpw==
X-Forwarded-Encrypted: i=1; AJvYcCXjVYqggTbjTbHNm16eadyAfPExNBsHWa4cDPCX+/WfaQZszFztXrY56JYlQzOokGXMGY9Ys75LIftSjY82YuIvO/y8qZbl7Q2Seo9SfHUBEpU7C2x98S3/3l7Unu5wVKzrWWD3E8aEKA==
X-Gm-Message-State: AOJu0Yx4zelWo3XApjqvYS++1A4fbjjPGA0XXo9R4TXvKvbBCifc6Bzg
	ok1QQdCyf4KwRykbNv5XQdkNAJ0CORLsWfDEMNKVvkKoTcPrFI1WxZ7z8dH8
X-Google-Smtp-Source: AGHT+IE4OMXQLC4WI9AcDsNC96FOSTroZcAL2AAxUP8XJ/nc6tezfB8M22m5VsFWfoiS1ec93eoKmw==
X-Received: by 2002:a2e:8054:0:b0:2e1:aa94:cf48 with SMTP id 38308e7fff4ca-2e95b096c3dmr76605501fa.20.1716913086682;
        Tue, 28 May 2024 09:18:06 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e986fc0e07sm2397661fa.76.2024.05.28.09.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:18:06 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e95a7545bdso10956231fa.2;
        Tue, 28 May 2024 09:18:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW76C89yyYYa2gECUPqAMWmsjZZgrl/O6RvifwMK6T+0F59TLUUjpoS56GkJfCj/hWobbAk/jP2B3iIgGWive8r9yz2sXa6VSEK2ibeyrupre0t1hUvbUOXRM9MnKu3PRJ0AJtADB993w==
X-Received: by 2002:a2e:9e45:0:b0:2e1:f38c:bd63 with SMTP id
 38308e7fff4ca-2e95b096cc7mr68621711fa.15.1716913086334; Tue, 28 May 2024
 09:18:06 -0700 (PDT)
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
Date: Wed, 29 May 2024 00:17:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v65+A2QUN6TWrKiOcgbTenYT7h=S3Ee1xEUN0e6vQCbgFg@mail.gmail.com>
Message-ID: <CAGb2v65+A2QUN6TWrKiOcgbTenYT7h=S3Ee1xEUN0e6vQCbgFg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H6
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
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

I had to do a quick rebase as the branch start point was incorrect. The
commit hashes will have changed. Rest assured that the patch is indeed
merged.


ChenYu

