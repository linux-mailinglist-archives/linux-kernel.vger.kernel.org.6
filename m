Return-Path: <linux-kernel+bounces-317118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9345496D96F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B10FB21AD9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB5019CD19;
	Thu,  5 Sep 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="21/jZmpj"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5919AD6C;
	Thu,  5 Sep 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540841; cv=none; b=GWw8EXNogXzkUArwcFE1cZTXFASI81QGMWYsLygaKnGTP6mgfD2pvuZOCgop5MkG/KMlMgecXYbcMRWqEHhA0PXY9mZHgPZginFayq+CVS7wEKc1LVq7TCWNbJX58N5NbhKMKe5voukm/xW9eF4yUROqxh1RtoOdDwTd4UXoRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540841; c=relaxed/simple;
	bh=myEmylp4i5GDbSfZbE7Tpf0Dx2dyVns4JNEsdBVa2c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCForIX9ZaZj+1hlCvm5S1MXN+0HFGh/1rZwuQMHyvHZSKEdGV+micfqVUc5jHUsyK8QZ1uFMQYgxtnE5HZJ6KZ92DhNyQSTBpuH8olPXHJ0Q4yBuIdqgP1cWl2udl0iVXM2/lFzzoHf371JvQTQgIvc8h52x2+mjbj2ZTuofkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=21/jZmpj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S8TgLN4Yw+ZDsSgCEATL+wXj3SWrLc1NWdPu6L5fBE4=; b=21/jZmpjxG4hMR0fX9Je0/oiDg
	Vu0xBtpk4fZ97NHAwFsWx23icchIIbviVUFRVeBa6KYR7Y40UpFyHn8M55LmuQ7HY6EBmt8K2nZt9
	04sYkBacpSWmI2q4o5WuJSgJHe4g7HYCYEaq9I82FebWM+Gjl8QCs2ShgrpzYMOSGNQI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smBza-006g5O-Ui; Thu, 05 Sep 2024 14:53:42 +0200
Date: Thu, 5 Sep 2024 14:53:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
Message-ID: <3f5bcc6c-5ee0-4fef-bb58-f7acf9551fc1@lunn.ch>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
 <20240904111456.87089-4-bigfoot@classfun.cn>
 <6030542f-070d-4d76-9a5a-fbfc6bd433e6@lunn.ch>
 <1e189c70-e677-453d-9e31-6637196c2b5c@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e189c70-e677-453d-9e31-6637196c2b5c@classfun.cn>

On Thu, Sep 05, 2024 at 07:17:03PM +0800, Junhao Xie wrote:
> On 2024/9/5 01:25, Andrew Lunn wrote:
> >> +&gmac1 {
> [...]
> > This has been discussed a few times. You should be using phy-mode
> > rgmii-id.
> 
> After I changed phy-mode to rgmii-id, it seemed to work,
> but it didn't transmit any data.
> Maybe I made a mistake or should I continue to use phy-mode rgmii?

How did you change the rx_delay and tx_delay?

In general, we want the PHY to add the delay, not the MAC. Most boards
in Linux do that. But boards using the motocomm PHY have got into a
cargo cult copy/paste of using the MAC to add the delays.

	Andrew

