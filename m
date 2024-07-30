Return-Path: <linux-kernel+bounces-267435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0C941172
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA94F2865A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C257919DF78;
	Tue, 30 Jul 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="bCfuqzSE"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7B1991CC;
	Tue, 30 Jul 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340979; cv=none; b=AvuQIRaJeo8Ak/a7i3s9Ugs71oEMN+JXzEip5v4zokjwA4uC9yVSmeZ8E9UBnkmkNjbBgdDRjjG0yjTR75HeMw61mXYGnOSkvoqM397dMTM2SQZhF1zHIivT8yvOHIBWkpHF31v/ahuTw+DL1SWjUAqmvG90onQsEgkbeGXRuhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340979; c=relaxed/simple;
	bh=lStTIQUJHejv0ssZ73mBBA2+tr3P4Dd58Y/zHgBAIew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nkr3yI3koN5jKVsMdVy6MOh6aotSkMSP9WOXf8sB1DKJzGzCTGyFSJOv/qbeeF09MwhLnVu/jZVSQA+iS3qs8VDmIgEwJYpIBsXxuLMopggH5PlTzer/+A2n1C1HX69Qucg6/scYxLR0ayiPYTvqhlTL8owbdMocdidXSy51WAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bCfuqzSE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 81BB81F91A;
	Tue, 30 Jul 2024 14:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1722340973;
	bh=nP4NemDPonFFUWQ21im9LmRH17qjmTdFCC4+gAVsyTk=; h=From:To:Subject;
	b=bCfuqzSEKyE/Bozf+V+HdyDfmiKeqdKy+Rkz8kwADg3zs1yQwh+GZz5C41Tf5uxge
	 H/H748mN/Rj7mgMUWXWh2r8T7mDUEpRL3v2KycZPLG4xraaGmWy2tJcQveKD4dx37o
	 5ylf4D8SunPLfnAxXYu4G9KqcefvSkORbOzwQPZVc0OtTBxxDEFefma7tqF1pzcR0b
	 ihoZQdiZs4i7g9Nmm/4KtQuXnaU4lLffcpzWoU7NcOj2rvUwDp/nJxKcKryHeGfJHJ
	 Nx5f6gGiIziZEtgpZ0uDWVfwX+TbYOcBUNi2UI/eOXukLh6IlqjLveGlXwWCDnlTVi
	 kBhT23HKrLM1Q==
Date: Tue, 30 Jul 2024 14:02:51 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Parth Pancholi <parth105105@gmail.com>,
	Jayesh Choudhary <j-choudhary@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs
Message-ID: <20240730120251.GB39114@francesco-nb>
References: <20240730093754.1659782-1-parth105105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730093754.1659782-1-parth105105@gmail.com>

Hello,

On Tue, Jul 30, 2024 at 11:37:54AM +0200, Parth Pancholi wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> Correct the McASP nodes - mcasp3 and mcasp4 with the right
> DMAs thread IDs as per TISCI documentation [1] for J784s4.
> This fixes the related McASPs probe failure due to incorrect
> DMA IDs.
> 
> Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/psil_cfg.html#psi-l-source-and-destination-thread-ids/ [1]
> Fixes: 5095ec4aa1ea ("arm64: dts: ti: k3-j784s4-main: Add McASP nodes")
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>

+ Jayesh that is the author of the commit fixed here.

Francesco


