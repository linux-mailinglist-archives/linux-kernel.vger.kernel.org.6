Return-Path: <linux-kernel+bounces-312262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E1969430
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3659A2823CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946C1D61AE;
	Tue,  3 Sep 2024 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="hMhz/Ndh"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156041D61AB;
	Tue,  3 Sep 2024 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346286; cv=none; b=shj/PftESUf76b+b+POcSZpJexROGwsrAnclRtolkKPVYPOKMUyxpMm+cKMTC+EYXavlY7YR848l5GhfzFxQBcVTABBTqcBAzCODyaPRKIAyvYsMykLJanStqiVPU4PA0Xoy64KXNGMhhqBK6bn+2IilQzMty4L/1Csr/x6n5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346286; c=relaxed/simple;
	bh=+8DhwfeIUfdwg8dPl1HJqPNLFuN0uTr25CZKKjbIBT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMo0FnqcgzA5ouVVlZjbKyRQT9UjJwC3mMW6coQF8rUuLbWpWyQ59QsUGiQqWVFWS1NhlAOrreZUiTGxS60jJEe9S4WRkEgBkYDQBiTsjZM1+aj1SGijP4e4lUsqbZKu3Md5ei3ctDySi4zgPBzyvQQjozi/Y+yVrb/5Z0UI8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=hMhz/Ndh; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=55f4XHL37VsO9pcrHztaTRFVBDM376ggqSU6M14kBEI=;
	b=hMhz/Ndhi7BpzOY84uNWJr7cFHmisZX0ABOOWpzUOoDMxgOijGr+USneaeaY8w
	LpgGL34XYHxLjfFgxwEdbTbV924+4KbouFB8pItKJK/+AduYXWFiS4fBRJjKInwl
	mjlhO7PysnV/Nx7V/BU5XSxbGpQOeUzcuXcZw8KaTHuWs=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDH7SbGsdZmYLZaAA--.38886S3;
	Tue, 03 Sep 2024 14:50:48 +0800 (CST)
Date: Tue, 3 Sep 2024 14:50:46 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Joy Zou <joy.zou@nxp.com>
Cc: frank.li@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, peng.fan@nxp.com,
	shawnguo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1088ardb: add new RTC PCF2131 support
Message-ID: <ZtaxxsKXwpLYPufQ@dragon>
References: <20240902103626.1414595-1-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902103626.1414595-1-joy.zou@nxp.com>
X-CM-TRANSID:Mc8vCgDH7SbGsdZmYLZaAA--.38886S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIco7DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwRPZWbWfG6ojAAAsj

On Mon, Sep 02, 2024 at 06:36:26PM +0800, Joy Zou wrote:
> Add RTC PCF2131 node for new ls1088ardb board..
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Applied, thanks!


