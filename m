Return-Path: <linux-kernel+bounces-301144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93E95ECF6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6E41C2186B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4E143C70;
	Mon, 26 Aug 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="n4wDlcQY"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9328F13A88D;
	Mon, 26 Aug 2024 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663985; cv=none; b=kpVmUHCsv58okkILAv5Vjk7v1CVXRRnN3aXb0wvp/L11TgDJkOaUww6kKb5poH1H4UkgpX8wffAWpywpn04VI2XizLxK+YwARzOJHa7kJzijd2qSw1vdNOtj2BH7MUJAOIqszVKfI5P64ZCUY39EoB+0C834EHBpOo1Xl+r0gI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663985; c=relaxed/simple;
	bh=0eRmK37KBjgcw2LNlR8+ezH5+oSLGu1OKO+3ua3wznQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qssAicm+HPTF+2v8OCj250QYHIB9E1TYuHXhxNXPxB/ErWerZi30LEIQOGtV5VneMVEH73LGNMgRagE1XnMBP9szk1eh1Tq/hrnK2dSKcoNAuMW1rMXM7Rxx93Ka8hGJaLaffL2Z4qnpQHIepLUwpKh32h9HU/QgIRJxwFFaV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=n4wDlcQY; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id B2EF940438C0; Mon, 26 Aug 2024 09:12:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su B2EF940438C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1724663564;
	bh=0eRmK37KBjgcw2LNlR8+ezH5+oSLGu1OKO+3ua3wznQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4wDlcQYxBU2vjkLqN1bp2NG0trUyjeDqZffXUkVeS6SBAAy2XOBLB5Nrt3oPoXwz
	 d7N3DrxYZ6JOND8Kp74SCWaWBSN1eiixSvZZgCanaH+8gnXvhI2CAgYK6TeeBvyim9
	 GXc9S75FfWwAG+h4XBq7k3Dd2lHqBSSMlFseZveOXArD9xBDbR5VpBHZps8wmdZliJ
	 tG0H0Sa6F9ohgH9ACPt9DerqKtfqLwxvWhIDerG7ThoICQ1q3aAdIIf9cuSTu0RFnp
	 2MQhCgT6LDNa8N5TvKxFoOUF/qDiE/SCuhy3d6svvN9+7r5MaXHsfs3TapdJrq1OzO
	 U9AlAO/+BDVxw==
Date: Mon, 26 Aug 2024 09:12:44 +0000
From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
To: m.plak@icloud.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	cnsztl@gmail.com
Subject: Re: [PATCH v3 0/3] Add DTS for NanoPi R2S Plus
Message-ID: <20240826091244.GA22141@ветеран.su>
References: <20240814170048.23816-1-jin@mediatomb.cc>
 <39753BDF-DC8C-4AA7-8BBC-621324BF75F3@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39753BDF-DC8C-4AA7-8BBC-621324BF75F3@icloud.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi,

On Sun, Aug 25, 2024 at 06:28:44PM +0200, m.plak@icloud.com wrote:
> On 14 Aug 2024, at 19:00, Sergey Bostandzhyan <jin@mediatomb.cc> wrote:
> > here is version 3 of the NanoPi R2S Plus patchset.
> 
> 
> Thanks! I was just experimenting with a patch for that board.
> 
> 
> eMMC:
> 
> A close cousin of that board, the NanoPi R2C Plus, similarly adds eMMC to 
> its base version, R2C.
> 
> R2C Plus is already supported by rk3328-nanopi-r2c-plus.dts.
> 
> The r2c-plus DTS file differs slightly from your patch.
> Would it not be better to use the same fragment for both r2s-plus and r2c-plus? 
> Or even place the eMMC activation in a shared dtsi file?

thank you for the additional review and testing!
If you followed the thread, then you probably know that I was way over my head
here, as I operate soleley in user space :) I was building a Yocto image for this
board for one of my clients and I figured I'll try to submit something that was 
already present in the FriendlyElec repos and which worked for me and with the 
help and guidance from Heiko and others we managed to get it in, which concluded 
my kernel adventure.

It'll be great if you or anyone else is willing to continue from this starting
point if further improvements are needed, because I unfortunately do not have the
capacity for it - I am happy if hardware "just works" and
very much appreciate the abstraction APIs that the kernel provides to folks like
me :)

> I’ve compared the two and the friendlyelec kernel (not u-boot) sources.
>  your patch does not contain these lines from r2c-plus:
>     vmmc-supply = <&vcc_io_33>;
>     vqmmc-supply = <&vcc18_emmc>;
>     mmc-ddr-1_8v;
> 
> your patch adds these lines that are not in r2c-plus:
>     supports-emmc;
>     disable-wp;
>     num-slots = <1>;
> 
> r2c-plus has a line that is in rk3328.dtsi already:
>     max-frequency = <150000000>; 
> 
> the friendlyelec kernel sources also add:
>     no-sd;
> 
> 
> From the description in the mmc-controller binding documentation, I believe
> disable-wp should not be used. The description for no-sd  I find confusing.
> Can't find num-slots and supports-emmc there.
> 
> The RK3288 datasheet does not mention support for DDR mode, so mmc-ddr-1_8v 
> surprises me a bit. The datasheet does explicitly mention that HS400 is _not_ 
> supported.

The mmc-ddr-1_8v change was suggested during review and I was asked to test if it
works and improves the eMMC speed (it did). Back then I have asked if someone who
knows what they are doing could take over, because I honestly have no clue
what these things do on hardware level and what the implications here are.
I was not let off the hook though, so I have just followed the instructions
of the reviewers. If it is not in the datasheed, then perhaps this line should
be removed after all?

> USB:
> 
> Another change with the Plus version of the R2S is that the USB 2.0 port that 
> used to be wired to the ethernet chip now is used for an external USB port. 
> I don’t have the hardware here (yet), so can't test if that USB 2.0 and the 
> USB 3.0 work independently or need to be explicitly separated.

Good to know that there may be an issue, to be honest I did not test USB
explicitly, but both ethernet ports work. I did not modify anything in that
regard anyway, since the R2S (non Plus) version was in the kernel already and
I just copy-pasted the eMMC lines from the FriendlyElec devicetree on top of that
to get eMMC to show up.

We only needed ethernet and eMMC to work on the R2S Plus, so we did not test
anything besides that.

I still have the hardware here, so I could quickly test a thing or two if
needed, just please make sure to e-mail me directly as I have already unsubscribed
from the mailing lists.

Kind regards,
Sergey


