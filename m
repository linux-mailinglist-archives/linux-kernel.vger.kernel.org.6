Return-Path: <linux-kernel+bounces-432537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082C29E4CA3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB6418819C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4448418FC8F;
	Thu,  5 Dec 2024 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk7zzFr7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E6383A2;
	Thu,  5 Dec 2024 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369275; cv=none; b=BSvKqp+CbnkSFPnQ61xw5tPD8jawBg5Ct0fhG7fxeYRVAiJmRvAu+n7Akh4WgSAbgSgXjbctYWzZUXX4doeQnN7MY75fmZtFn9h5PxsLgxTFlCxs9j0vBykIAjPRkDtGdksP8JOP0Is1W4/ucppl/4gXtupGRuuACzVcLdRDVBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369275; c=relaxed/simple;
	bh=3lIpUuEcs8lr9qJddLay7lxFzw0wDPYhJ7365yPVjaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9D2Z9XyD1P2M1zCY1BxPrcj2F/18IZAUOwC1nbjfsyZpnEDewBWwO59jGtbU2xsJk6D7di/ehtxgzwINImvGiQQSl4e/1uEMLVHseNl5YPqXSn/fAuOl7tz/M1RvE6NnwG6HWyywx6acN2NmBsHLCqcZI6vz0X9rLkUssXSHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk7zzFr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9661C4CED6;
	Thu,  5 Dec 2024 03:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733369275;
	bh=3lIpUuEcs8lr9qJddLay7lxFzw0wDPYhJ7365yPVjaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hk7zzFr7BujtdGOYlk998kUcig1eJELsjtYd/TIaf+oEqwCTmBbU7bnl9VCSYfYkI
	 hISx09T9/HcuU/Wf3aMhYWRjhm+yAtuZj0A41sSBvsDFAUWExZkp6GG+OI957eGzJv
	 v4efbFtnSNqiPKZFJ0fHjOxeVosSmmILXJ5OUbq9Mb3kyEtbVZfAQrnWHYrXnOJHUE
	 v5Fcc/Gy9/CCdfbxcU1EZ+8jJ5Cf08h31CCMVEjXB8Lcmf5DaskvrMaAKaHWxVppP9
	 Jnr55GCwaTAy3Dwz4JB54XaqTCtgY5mYdX84DgBRfjuDdnfdA3QqnlEi3dP22h8KON
	 WWFSsderkp1Tg==
Date: Wed, 4 Dec 2024 19:27:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Joyce Ooi <joyce.ooi@intel.com>,
 linux@armlinux.org.uk, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 0/2] altera: simplify probe
Message-ID: <20241204192754.139a0292@kernel.org>
In-Reply-To: <20241203233150.184194-1-rosenp@gmail.com>
References: <20241203233150.184194-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 15:31:48 -0800 Rosen Penev wrote:
> A small devm change with goto removals and a function simplification.

Please don't post pure devm conversions, unless you're actively
developing the driver and can test on real HW.

