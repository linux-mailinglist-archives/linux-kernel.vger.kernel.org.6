Return-Path: <linux-kernel+bounces-284840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C29505B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE311C20C16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E619D07B;
	Tue, 13 Aug 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeuruCEO"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35B19B3D8;
	Tue, 13 Aug 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553801; cv=none; b=Wz/+nkleBXRyAABdxoBQDUje+PJiWdlE/hX9z/sm3UXjxxX6gN3BBHQzdCe46IxQxXH92GKuIImsFvrH2KKBJP8YS5VFJ4HM2DpGORg05GZ1JwVL0BR+50EBpNfHbFIUNmSZ8dGr/4phimwtMA2uDxhyiNh+kDT90la8c+d3lAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553801; c=relaxed/simple;
	bh=whbRnYju75UWipX2ZGr+GH/9h9Pj/Z1GL6BBF28Y3jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMHkwAfc/LRGGAr65HFTmebrcizzxJ1lkXUdaYFLUk0oBH87kUdCd1axMmop/U8U/E8zJdKTBqoOcuT/RAjmtKUuXVemJlUE5k9Fn2jf5lxbFUEOjtgOR5ugCpvf8tx1Uaxuy9dtwW1GQRPMElPmT4x5Vy3Ehxy071oROeSVjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeuruCEO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367990aaef3so3095370f8f.0;
        Tue, 13 Aug 2024 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723553798; x=1724158598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0tUAb7xzL2y2cfaINDDXHjm40ddk5vPxuhg5vBeQr8=;
        b=SeuruCEONfA3aceGqvP8mGldFdh35xtCL9zyE852L/Vlwfl6oZy+v1w5Myezl1n9Sr
         kTY4szp7Xmhv+d67M1VSKTmDadf3MaoNs2fl6E4skQfmqlmAMmzGZPs+/pI+p1b+RnRs
         OshF7iEBYc2B0nQR8KnOYuhcTFDccZ3URETgkfDygTRd0iqxMeW6N9FRc4EQuTNZwnBk
         3ZueRK92Ffb+KvsSb+DZXDet5bgWNMwKZ6Xsca37N72nV276V9vexGdK1VMDT66xRnwT
         2S5l93o5kw1SU0yUKV7gKCc38T05FWjvTmVLKw6ZDLd3fEfzNjWuwlwPVcMZCXuMGETj
         4Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723553798; x=1724158598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0tUAb7xzL2y2cfaINDDXHjm40ddk5vPxuhg5vBeQr8=;
        b=Sfcvqj//od0Td6Wx54mTxF7WlG+vgvT0pCxgRcQ3xe8X5wQOGjAMS4QMB0ivEr33iz
         Y9tAzs78LQ1hqQkDnKJYX1HLqjH4HBiOJ63D0WH/I4Sr/B8esgeqWmfF8M2uXYj+sN+Y
         Unumfc51M9GOuaCXdBlDL7F2tgNktSl0wQWFDJ0kFAXT1qO/8lSPqYH7sr/Ei4Wfj0ou
         lENu2XsKIWNuexj5a18mbv6mNuhl/nanxHObCu1fEIeNR0jD2c0isNHb2npJ06Eq5esf
         xWkwQ5rBPP0XJLourNjaD+tDLOVF86V9AHcqeU7aIJoCR30DO/LnlYsz+I6JD0G11KzC
         b7IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOIJFWjfl3waFsq51yBRj2GybUZ+n3XpNHoXjN1o4QEzqBCr6umEnF9++wpn6aAAIMm99G3VFXWvi6kGpZhGo3KIyAApGqBHcFqiGP
X-Gm-Message-State: AOJu0YxNiHLAc2p2OJS+h0hahhKNsmlL+tZ1HQdGxUVIxxV80zuqMOJg
	+EEEbjQ/IjkxWOhxKX6YDNIv/BikANn39hrMYKeC1c/XikHgdqF0z1UEl8voXku/pspztEZYyMu
	w3idSRZjFsMqzqC3C6/I444ZGnII=
X-Google-Smtp-Source: AGHT+IFo1+br8YX61HWh8cYSwERwzh+iP0J5n6X1I0605mKTFVkgDpdxxygsikzkjEZKdPfOlxzi7VeiAH5fyo8sLys=
X-Received: by 2002:a5d:4882:0:b0:368:31c7:19d9 with SMTP id
 ffacd0b85a97d-3716cceba21mr2151749f8f.12.1723553797884; Tue, 13 Aug 2024
 05:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804002912.3293177-2-crwulff@gmail.com> <2024081335-wrist-earpiece-a738@gregkh>
In-Reply-To: <2024081335-wrist-earpiece-a738@gregkh>
From: Chris Wulff <crwulff@gmail.com>
Date: Tue, 13 Aug 2024 08:56:26 -0400
Message-ID: <CAB0kiB+ONUpx9Ozg9x836BEdCtSSm-J+jpy2BKoDgVF1CP9O9Q@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: f_uac1: Change volume name and remove alt names
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Perr Zhang <perr@usb7.net>, 
	Pavel Hofman <pavel.hofman@ivitera.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 4:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Aug 03, 2024 at 08:29:13PM -0400, crwulff@gmail.com wrote:
> > From: Chris Wulff <crwulff@gmail.com>
> >
> > This changes the UAPI to align with disussion of alt settings work.
> >
> > fu_name is renamed to fu_vol_name, and alt settings mode names
> > are removed for now in favor of future work where they will be
> > settable in subdirectories for each alt mode.
> >
> > discussion thread for api changes for alt mode settings:
> > https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@=
ivitera.com/T/
>
> What is now going to break due to this change?  What userspace tools use
> the old names that need to be changed?
>
> Are you _SURE_ that you can rename external files like this and
> everything will keep on working?

Nothing is using them, since they were just introduced. I wanted to get
the API changed before they make it to mainline and somebody starts
using them.

You just applied the patch that introduced them into usb-next on 7/31/2024,
just after v6.11-rc1 so they haven't yet made it to the mainline kernel.

This is the patch that introduces them:

https://lore.kernel.org/all/CO1PR17MB541911B0C80D21E4B575E48CE1112@CO1PR17M=
B5419.namprd17.prod.outlook.com/

>
> thanks,
>
> greg k-h

