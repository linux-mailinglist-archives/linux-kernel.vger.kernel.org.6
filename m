Return-Path: <linux-kernel+bounces-386866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D549C9B48CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD58283A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E437205AB0;
	Tue, 29 Oct 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it6q1G9W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C707464;
	Tue, 29 Oct 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203132; cv=none; b=pGBjuGbZug+qgj/84qfMW5mA3HEilE97yZuf9SvNQfHiptw1Ue3piS27lUa5ALZh4DIiepOVclfCRFdb1bDwTKCmBe8gHSvAWdZsYWm+Bh3Ye8t8MLM+VLoUomiEuBci5h82H9kcmjjbxlpTn3Cy1W/5kdOVHa+IJjaZ1n9hWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203132; c=relaxed/simple;
	bh=SzhROuVj8b2Bw6HW3TeWKNJXntWzXA8ZH9yg8zdzvxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVbFi8H0lAgnPVcpZad0mQF58F3nj4eWpfBc1e6TNKPvpPGcOpyRKBSiBKbSiGGKNNrmb/7EXkVMeDa/2I9r2RD/srzEqukXiaxVBEO2MH7q92QMSuGfqX2LNI1c8dFuKp/Bs/ck09UxIVa2XckqNsuUD0087D+2n5dKjSfyZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it6q1G9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC06C4CECD;
	Tue, 29 Oct 2024 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730203132;
	bh=SzhROuVj8b2Bw6HW3TeWKNJXntWzXA8ZH9yg8zdzvxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=it6q1G9WfgDOaBHu8ulzoYpgaX2OjuAmWBVBedB1caaIfVgpJtoeZQOiarq1wRhBY
	 3opyDtKFW0ZFw17JM5/iH+zaqym/+D3ZgaRXtH3rx8oTgV3wDBHdutTwexkakJcdC0
	 gWMld7EYJWJHsea01fDZ4kGbN6darGpmMSCgaY0fOoCnAIomN8+sLs13YyzlIcBUXC
	 CwoPBw3Io0ohdT6mh0MBtRQbuLRp1ivPcYM7R4sAoFyKyPF0chBOFBfl7/oCYqWGu6
	 NF9GrKMXB0x9rUH7ag88rc/mc/PFcrcU+iLBopnC7cvdpzpaqJEoOFrzZ6C3Rs5ja4
	 9DpZNECtax+wA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5ksR-000000002MX-2DLu;
	Tue, 29 Oct 2024 12:59:11 +0100
Date: Tue, 29 Oct 2024 12:59:11 +0100
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel RG650V
Message-ID: <ZyDOD38s_n7SyupZ@hovoldconsulting.com>
References: <20241024150919.53046-1-benoit.monin@gmx.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024150919.53046-1-benoit.monin@gmx.fr>

On Thu, Oct 24, 2024 at 05:09:19PM +0200, Benoît Monin wrote:
> Add support for Quectel RG650V which is based on Qualcomm SDX65 chip.
> The composition is DIAG / NMEA / AT / AT / QMI.
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  4 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0122 Rev=05.15
> S:  Manufacturer=Quectel
> S:  Product=RG650V-EU
> S:  SerialNumber=xxxxxxx
> C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=9ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=9ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=9ms
> Signed-off-by: Benoît Monin <benoit.monin@gmx.fr>

Next time make sure to add an empty line before your SoB.

Applied, thanks.

Johan

