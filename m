Return-Path: <linux-kernel+bounces-550595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834EA561BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83F51893D00
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5DD1A316A;
	Fri,  7 Mar 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VTs6f9J+"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAC19DF8B;
	Fri,  7 Mar 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332410; cv=none; b=Hzh/OclQRFG6PyEQVGGYlBCMrYq5ggdvUy9ulIPGnHYiDI4dPeazLvE/aXESOseu37PowwFwlISsYm2VCW+3AA0YbEMJ+SuajUk19XfgjuM/+Pf64rAGHiiAEoCNd174lHDq/pDWtG8ZEAlB/0uXFkQxNb30oCk5Km3Cxy2/LGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332410; c=relaxed/simple;
	bh=rHjEprSJcpdEoMkrk4oD6J2HzcQmBbR3rYUXuMkEysQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouqMmJZ/bcwV0KDor3uPd8vsoLkExIThGBnd0z94MWzyrI3RRKf2NCWFnjCvTAmVAi/iJp2ET9nIbVv8gKiUZidDc0RdstPVYUslnerFTRWpMuHXcXGx1WjRkKyZnY66ru6G2yFuv3UMnwfi+0pENmCUKvfRgykKy2wa/spjDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VTs6f9J+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B8CAB25C59;
	Fri,  7 Mar 2025 08:26:45 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BRtfGReBau6t; Fri,  7 Mar 2025 08:26:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741332405; bh=rHjEprSJcpdEoMkrk4oD6J2HzcQmBbR3rYUXuMkEysQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VTs6f9J+r5YfaSr5Jn0gvzobij5DBiIy9KofBPO53N4hhVw3aFrZj9clRqkXitNB1
	 En4gLWWEnyFH4YYL8zI2C8Ld7j3kT9RZy79gfdz/xukvE7mKW2A01vK/5TB1dziu9x
	 /5T5md/c5AunmxsKjQ6+UI7gF3Le8eoDyB2fMjNCGct489+992/RHVpjzSxp+2VYGh
	 S8Y0lROUVenasXWr3tBXWwJm4pQ5ttBg0wCSdhmzil5blWtORZUdZ/BfLB8NEsakck
	 xfBukjJaIIJ2fuZasUnh9XvORSFoK8CnjyF7TB2YNXdc/g7EpIiNAdfKey0UsZH9uA
	 mpbAAp1gtCZUA==
Date: Fri, 7 Mar 2025 07:26:23 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chukun Pan <amadeus@jmu.edu.cn>, jonas@kwiboo.se
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com, devicetree@vger.kernel.org,
	heiko@sntech.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
Message-ID: <Z8qfn-OTgopD8YMO@pie>
References: <5a0a7ce1-1dfb-4d19-8a1e-0d89d177f5b8@kwiboo.se>
 <20250307071020.756277-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307071020.756277-1-amadeus@jmu.edu.cn>

On Fri, Mar 07, 2025 at 03:10:20PM +0800, Chukun Pan wrote:
> Hi,
> 
> > On the E20C the sdmmc controller is routed to a microSD card slot mainly
> > intended for use with microSD-cards and should normally not need SDIO.
> > 
> > What card/adapter do you have inserted in the microSD card slot that
> > requires use of SDIO instead of just SD or MMC? What is the use case you
> > have that requires removal of no-sdio on E20C?
> 
> I inserted an sdio wifi module (via sdcard adapter) for testing.
> Just out of curiosity :)

I doubt whether the module actually works, they usually require more
pins than a simple SDIO bus to function. Additionally, it really doesn't
sound like a real use case for me.

Have you tried transferring some data? The log you showed only indicates
the controller doesn't bail out or freeze when encountering SDIO command
sequences during initialization, but cannot prove the controller is
really in a good state and could transfer as normal.

Again, connecting SDIO WiFi modules to a SDcard slot doesn't seem an
usual case for me. I'll change my mind to keep SDIO sequence disabled if
you didn't get the module really working but only observed the
initialization didn't fail,

> Thanks,
> Chukun
> 
> -- 
> 2.25.1
> 

Best regards,
Yao Zi

