Return-Path: <linux-kernel+bounces-323943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E39745D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7981C213E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC11ACDF9;
	Tue, 10 Sep 2024 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6KHVgFr3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B71ABEA9;
	Tue, 10 Sep 2024 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006835; cv=none; b=qh3RchjpzSqTZVLUJjGE7PnyDL1e1lIG89ES/9dVVLkxD/tv+MvGXCtaJA70kHcxCCQXPypkf7FRVAD1EmvgSgTEd/FJRBeuRJlYTFn/nSiLwK4y2S62y2Nw/zxJIm8WvJaiL1t7UoFpgTNodr0AASWIVvzUqARsq+QgREixgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006835; c=relaxed/simple;
	bh=RTPNZzLRDQadj/kll/i0qJCSbLBYvrWqTxiWmE2xxDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzpSWaGzO1p0R8g4EJ+ZK0SuET5XYrwnvdKG4hmayvL2awZGBbTU8Nxat/PKldKDP8VJW4kuLDKBQ+ycWzmiXScjQ9FoTOlwn7q8CMxIIgI62Qiahvtcy8GS52JBo2UWjFFhXqyqWV4DcpWNo9qSYmax3DbK7qD0iqWa4K9D60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6KHVgFr3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=adrGJApwc/ds/la2vhWptTl82lgjp3gICkNWHjbmAL0=; b=6KHVgFr3Zajgx5ZUXSsn0Mk8zQ
	N6z4heTogb4kSChlUhysQ8129cRW8tBS7mla8rPgh+Ir52osu8yyF21SaVAiuTgJuZHZjqHDWIfY0
	3cXKussYru/T3K0/lbz4kMUSCUd41/E8VngcIFRfUErctktCVHYNzlLyBV7Qeoguwpow=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1so9Dm-0079Iu-IW; Wed, 11 Sep 2024 00:20:26 +0200
Date: Wed, 11 Sep 2024 00:20:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: marvell: kirkwood: Fix at24 EEPROM node name
Message-ID: <b8f6aa8b-0d02-4f74-ade1-4c544eae5360@lunn.ch>
References: <20240910215914.823546-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910215914.823546-1-robh@kernel.org>

On Tue, Sep 10, 2024 at 04:59:13PM -0500, Rob Herring (Arm) wrote:
> at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

