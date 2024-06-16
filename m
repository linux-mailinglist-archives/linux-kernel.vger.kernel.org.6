Return-Path: <linux-kernel+bounces-216277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B96909D6F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 14:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AD41F21476
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED5D187564;
	Sun, 16 Jun 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="pJ82Ecj1"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E841A186E44;
	Sun, 16 Jun 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718540579; cv=none; b=Z4RNjtKJ/3r8iBXLH8fB1B1GF8yVE5jM6MvyJZnmgPAIVM0jIYzy9E37ExH6Ji/9VHJfaEkUxX0III+y+1YAoFJaFJY9Dg6cifgBmejXSYQS5vUbsrxDESEoE4HuQIBZ089hkIAoX+Lqc4xOswBn76LNcg1++5AeYvzSwIub2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718540579; c=relaxed/simple;
	bh=laI1+Jq1NU6RrnRY0zSdr86w8tIqz0X/38YqYhgoY/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a88Gx7me62evpJ9TEn41U2vceQek15RxzJVH6VZMjttYuCZ02cro0MNh6GNjeJ0hgmCPRxhyJQj2qzy7pKa9eRZYQ9inYVCeEFXYEhnYkgQlj67bTbwLifzew+JEvbikK0MYUrOxx+AlTEC+ckOGegAQzUQTKhu2sS5CcLDgGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=pJ82Ecj1; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=b91uB0erFS7aQHYdMCKwO4zVsP6GD3eL3+ML+uqiaSo=;
	b=pJ82Ecj1+dEJ1uvLwImHlp8T5SpjzA/vdGkYsZeDMVCQSSpjobSuZLaC5nVzI5
	WWA7Jpk7vQAd0vZazw1ILncdwn1ErHqnRoDSRKhQ1CAbVTkZx6h58AP66FL5q9An
	WNNpOynu16Mjb5S0rxE+cT4gf9E07EusIBLcGe2/UqtBE=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAA3nvoQ2W5m9pUCCA--.39502S3;
	Sun, 16 Jun 2024 20:22:41 +0800 (CST)
Date: Sun, 16 Jun 2024 20:22:40 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a-rdb: Add EEPROM nodes to I2C bus
Message-ID: <Zm7ZEEYWgdTs6i0/@dragon>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c99f8488-228d-4347-9f04-8a0b4c3c2a3f@emailsignatures365.codetwo.com>
 <20240604062723.82703-1-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604062723.82703-1-mike.looijmans@topic.nl>
X-CM-TRANSID:ClUQrAA3nvoQ2W5m9pUCCA--.39502S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUx0tCDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBREAZVsVCpsu3AAAsc

On Tue, Jun 04, 2024 at 08:27:22AM +0200, Mike Looijmans wrote:
> The LS1028ARDB board contains three EEPROM devices, for
> storing boot code, DDR SPD and board information. Add the
> missing entries to the devicetree.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Applied, thanks!


