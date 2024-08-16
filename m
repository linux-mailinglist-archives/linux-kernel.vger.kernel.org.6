Return-Path: <linux-kernel+bounces-289468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FBB954688
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C255B214CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D6172BDC;
	Fri, 16 Aug 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="Kf4Rjgis"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658B170A2D;
	Fri, 16 Aug 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803039; cv=none; b=SnOV50XXPNlnDccW/IcaP09cv7pL4aD/9YgegsQUg0bNRV5dmMP4zBC0HSoaEiPw6f/voUA4fvMN5JRxlnEg4n4cYUuspSlIoC1Llpk33zFy3u25RpF1t5ZKAKYyxKUU1fwpEGMj7WxvZLjEk1NgEsgv3hgCDiSNgxQAyQZS/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803039; c=relaxed/simple;
	bh=8PnY6ixqsAoTmvoPYVNiLNZjGToDbEwFtSVLO2CL+hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgCL5lBsqaVcVEPyTTmNAp6VXaBi6WoIvwQTMye0iN+kBaxB/YzeDkZRF68MS/vIrPMLWZS5WQdQUF+FkcYTQIXBH2J/QXijNwf/a1KVrcCT6GNj1wuWqMhKLsJXWBHlyUfKueGX7V+S9EhgF3XbihGdKy1rXsJryJpZl7MTadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=Kf4Rjgis; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id 6418440005C1; Fri, 16 Aug 2024 10:10:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su 6418440005C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1723803018;
	bh=8PnY6ixqsAoTmvoPYVNiLNZjGToDbEwFtSVLO2CL+hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kf4RjgisE1JyRq2z8ZDh/EHzOiRO0w7GKQ92NB7qdEPAarpRZ9hKmjv/12eGkU+fS
	 OBqKFp2auis09NoRVLoo057/ZNxBgbjDItLeVAIdnrB7HKb1odzRHWFmM+pO3gW7zw
	 5bbGgunBCKnEZRjIW0Dl/hcPbbjyvSJtI+aZwH1wVbCJlOTtLujFUh/+uLvHobHgx0
	 V1Tbg6F9+opwRh27EvYWcg7WLU/s9LmhpwVWobZKssWw3mNvlbcG/AV7+FyM/nIL1n
	 h8WcTGcGMn6KXM/5qITcRVwxMzmoNVmmYb/KLc1mg+aWflxn/ECb1YiUT+SlPWaHRa
	 lwUGdkP9jqdUQ==
Date: Fri, 16 Aug 2024 10:10:18 +0000
From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
To: Dragan Simic <dsimic@manjaro.org>, heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: improve eMMC speed on
 NanoPi R2S Plus
Message-ID: <20240816101017.GB28881@ветеран.su>
References: <20240814170048.23816-1-jin@mediatomb.cc>
 <20240814170048.23816-4-jin@mediatomb.cc>
 <002107db3dcf3f1d1d1a767f049b5b79@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002107db3dcf3f1d1d1a767f049b5b79@manjaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi,

On Fri, Aug 16, 2024 at 08:51:40AM +0200, Dragan Simic wrote:
> On 2024-08-14 19:00, Sergey Bostandzhyan wrote:
> >This change has been suggested by Daniel Golle during patch review,
> >adding mmc-hs200-1_8v; makes sure that eMMC gets detected as HS200
> >which improves it's performance.
> 
> Describing who suggested the patch in the patch description looks
> out of place.  Instead, you should add a Suggested-by tag, whose
> purpose is exactly to describe who suggested the patch.

thank you for the pointer, I guess I missed that, I generally had a hard time to 
come to grips with the hole process as there are so many details and nuances.

Heiko, I guess it is too late to fix that now, sine you wrote that the
patch has been applied?

Kind regards,
Sergey



> >---
> > arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> >b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> >index 12eabdbf8fe8..146b1da198b8 100644
> >--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> >+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> >@@ -23,6 +23,7 @@
> > 	cap-mmc-highspeed;
> > 	supports-emmc;
> > 	disable-wp;
> >+	mmc-hs200-1_8v;
> > 	non-removable;
> > 	num-slots = <1>;
> > 	pinctrl-names = "default";

