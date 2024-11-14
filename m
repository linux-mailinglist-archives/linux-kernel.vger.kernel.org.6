Return-Path: <linux-kernel+bounces-409416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3412A9C8CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A62FB36570
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EBB81AC8;
	Thu, 14 Nov 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qo6IhE/K"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD392C190;
	Thu, 14 Nov 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592892; cv=none; b=CxQK404c+AoEg6jgFVaRt/biIZEnHHlVVXXtgJsTdmjYRfrWZKNFSTabvZgJIuZQfzXvaIwlCJY17/NwoyS3SHEXOv3qbn27sV6BRgxqbQCMdcfgNyf9WxCgKowMY3Lys/1XZ6RRB+nmwApd54KPSKI3oCzKhVri/JOI7Jt5Oho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592892; c=relaxed/simple;
	bh=F82bp10B1R34dMM8FSTHf9CjM26J6gBIwsgMshuKpYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My5MGxvM/CWGCwOFaXW54F0ybDjnD6ePIC4Obooc1oXbGQOKZ32KBpIfU8MIzElKSQQnyNpg6qiBSHFVOEBROQ/rpnEEhLNkMYrygpE16R3HThOWScVI6sZBaZQTi8LPBStEtZtaR160prYxHsqOlnbK2eV61WwjKc+/l2NBlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qo6IhE/K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MMrMd96M8K1ChNocSe4WNcB5c2cu4idUNGZaele1Xfk=; b=Qo6IhE/KGUP1kWfmSbapGlQDuC
	tWxXuZDslASA4YE3ISImFDG2umMExvJbJ2r1rSH/YowKg4qVlgq5uTbuAV+ms16e6IXGD3HSzd6RU
	IKRBN3Vn5VBksqWaIZ43TJWD6dbG9u+VQ4TIddp2IYjvq154Rz+hGp2pOI370rP86gTk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBaPR-00DIqR-80; Thu, 14 Nov 2024 15:01:21 +0100
Date: Thu, 14 Nov 2024 15:01:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, salee@marvell.com,
	dingwei@marvell.com
Subject: Re: [PATCH 1/1] arm64: dts: marvell: use reset controller to reset
 mac
Message-ID: <2ade2839-1e31-4124-aec6-7382c3da8b70@lunn.ch>
References: <20241112071350.762111-1-jpatel2@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112071350.762111-1-jpatel2@marvell.com>

On Mon, Nov 11, 2024 at 11:13:50PM -0800, Jenishkumar Maheshbhai Patel wrote:
> change mac reset and mac reset bits to reset controller

Why does this look to undo what the previous patch just did?

Please add more to the commit message, explaining this and the
previous patch in more detail.

    Andrew

---
pw-bot: cr

