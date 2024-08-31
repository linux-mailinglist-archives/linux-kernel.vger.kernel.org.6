Return-Path: <linux-kernel+bounces-309901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B79671A7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D50D1F22B6B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6142C181334;
	Sat, 31 Aug 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="I6p7xKQB"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E50F2AF05;
	Sat, 31 Aug 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725108933; cv=none; b=tCJ2mqv2OvPIW37iXi6cH+MFUJul1QT8K55R96AP0sChaYP3ko8fszQ3qtulDfjtT2faCvXp8FsC8Q1On/8UB/M2TQOKRVAjlQruaERN7x+q/IBw2b7yGtfezLFRokgzvaliRFnVdfJNSp4aMaBFpakMtNl1KN72rS9ETF+dFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725108933; c=relaxed/simple;
	bh=owomlQr8/F6YqjT+6uGIkj02JvKiA5zjZrYQtMFE4Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie3WVsicCPgDNLBWR2h8TV8bqD2rTNYk66w3AybuP8xImRghRXoLcxliKcuIyaq+za7W/IuaY99cngogUrpJCMhTTMZnbQnkWUeFYQLJU2SOT8pkk1IYCeoT+Y0ClJFmn8eJUno2My1nBrw88A2UbE90gZhvXf1MhNlZyo+T9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=I6p7xKQB; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=6xPUOQoHw7J1hQT40FBfy6ZWsRjtvI0U3y75Xqpiio8=;
	b=I6p7xKQBA23kn1TUkw+o4oVZpO5MaftVgjb3DFcnOLaCK+btYoMzIMpm2GIGpP
	QU79nd3QdQHr1hAHoK4vHNw/P65QftEekHbFbpNvbEwcnHrsVKr8uwdRErsl6Zqu
	mCAbq323RivT1jhs9+EU0eyQ6y3V6lMj/rwrk8is3c2Eg=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCX_jWjEtNmHnM6AA--.16195S3;
	Sat, 31 Aug 2024 20:55:01 +0800 (CST)
Date: Sat, 31 Aug 2024 20:54:59 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: arm: fsl: correct spelling of TQ-Systems
Message-ID: <ZtMSowxZF1WCgUJr@dragon>
References: <20240813071242.71928-1-Max.Merchel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813071242.71928-1-Max.Merchel@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgCX_jWjEtNmHnM6AA--.16195S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUec_-DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRlMZWbS+P4w-gAAsF

On Tue, Aug 13, 2024 at 09:12:42AM +0200, Max Merchel wrote:
> TQ-Systems is written with a hyphen. The incorrect spelling with spaces
> is therefore corrected.
> 
> While at it, comments are added to TQMa6ULLx.
> 
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>

Applied, thanks!


