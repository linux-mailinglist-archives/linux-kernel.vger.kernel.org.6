Return-Path: <linux-kernel+bounces-430371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FFE9E300C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1BBB26C27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E920A5FC;
	Tue,  3 Dec 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RBwVJBx4"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD5205E2F;
	Tue,  3 Dec 2024 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269483; cv=none; b=Da+EreRWUrk/q8j40urppex7M4ksTSLHYZfNhgSQ+OUv30lBf1E7D8rOKHvd4QyduiwjV+nuD41GZ3K3ZUB57QiapoV99bOJjSTUKgmyXDBSDcRJsSt+5fJQ8SafUUPqlrI6wr+P6yDFcf2AFhayTvgzkzAVJKDn1KgrB59e9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269483; c=relaxed/simple;
	bh=majIc6JaTF5pk34ZwUXyzmdhZq54bZMyYULYqxYkDLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwFaPe7VAZ0gWZcw+2poh0Mo+uHDlNCVE36njXMgxRJMDn0flgSN5996APs2R+7pg3WECwinbD8CVmQ5xW+1iCT8BBXIT1hmWeRtoiG22jVJ0rRLMJwqBqJ1Adud+hfOs9Srkml6P1rypPXeyq4bVtiwUoFWwF0A9P9Qv9dcZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RBwVJBx4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Trjg3XKf8XqrRAptBiCMnEb1A1gMqUUnkTHFyr8IYgU=; b=RBwVJBx4eTvXad3B9AgWHtxAKF
	L0MFHpiHDRc3fe0yt5G9T1dsxQwyq3K5It/Mb0oGr6dij8VDaRLU9HvwJCNWu0b0Vxv8sQrsKvKs7
	aSTbqwE5AJVe7d8Ah5s76os1KEjZot+xsYG/xh/0QPWWN7sfkJzfZXhw2DXQXpExR4Dg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIcZH-00F95z-3V; Wed, 04 Dec 2024 00:44:35 +0100
Date: Wed, 4 Dec 2024 00:44:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: armada-3720-gl-mv1000: use nvmem-layout
Message-ID: <560369d3-e37c-4c44-86df-a0b81c899f9a@lunn.ch>
References: <20241203233717.185016-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203233717.185016-1-rosenp@gmail.com>

On Tue, Dec 03, 2024 at 03:37:17PM -0800, Rosen Penev wrote:
> nvmem-layout is a more flexible replacement for nvmem-cells.

Do you have this reference board? How did you test this patch?

	Andrew

