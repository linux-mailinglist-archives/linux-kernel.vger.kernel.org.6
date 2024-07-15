Return-Path: <linux-kernel+bounces-252648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531A3931654
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09421F2251D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF818E771;
	Mon, 15 Jul 2024 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4ZOCMPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A73E180A70;
	Mon, 15 Jul 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052184; cv=none; b=mJPd1oGevJDjz/n2IX0Ain0qM8/bjXNne6I7aGWlFFVhlSNO2vPAEWY7PPtcEaR9K9EMlaiJF1+okrUt3K4TnF8PThZXYVbjDCWvDtt8PNwDJRCqD1SSUbdpf3ZCGlZTK7k0ehxR/OR3Sm8I6rmfehmHnN0cnzVk2l86dYjZxdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052184; c=relaxed/simple;
	bh=q2kmb7iqudj32/vqxdTmeBnwBdx1BZ5aJv5iK6I82Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nrc+2KdPzUivaLKEziPViPwitRpumDkdvcu6tR920SKv3zJlbB0Qcs3pJdudGZYS9Wy2H88ARldJfGag1DJKy3M5PzJ7IXQo0fSWz2IbsbXCm0hIYz9AUEa/WKYXwEIkaqnV5zWAFKodh5DtthdvJ5k6bkRFLfyQSj1fupkO7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4ZOCMPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECD7C32782;
	Mon, 15 Jul 2024 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052184;
	bh=q2kmb7iqudj32/vqxdTmeBnwBdx1BZ5aJv5iK6I82Ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q4ZOCMPOd6i4r/c9ZF/veM1FVN1lqhIUlU2ntJR4MLmcrCb5RNp54vmI7voUV5yuH
	 Itu9AyLW9YBGh9ZFNrMwN/IzaOj78lw6ZCoUunhRbhf1PrzfdJkt/EtigUJ9Tbwtma
	 ietKpD+3AmHxR9DTcYqGho9P3YN8XFuMvgNZ9qqy0KIT/tvsxjxdvrU9F2TkmkFTLw
	 6ait0+WT4e8FVDsn/swF4IrigALr+1/4ZH+H5J0H00hVO5y5KKfNu8ghJRZyTkxQ1z
	 wA/Zxa8ujlaxbJYjOuGTbODi892s959oimaB9Oky+Dkhp7ODzMTzUltbQ2X4Y1yaJ7
	 51S33YpK0HV/Q==
Date: Mon, 15 Jul 2024 07:03:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jacob.e.keller@intel.com, horms@kernel.org,
 u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ethernet: lantiq_etop: remove
 redundant device name setup
Message-ID: <20240715070302.3d4d1cf0@kernel.org>
In-Reply-To: <92570003-ddcd-482b-80e1-1da1fa0cc91f@lunn.ch>
References: <20240713170920.863171-1-olek2@wp.pl>
	<92570003-ddcd-482b-80e1-1da1fa0cc91f@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jul 2024 20:02:49 +0200 Andrew Lunn wrote:
> maybe you can remove all these as well?

+1 seems like a good cleanup (after the merge window is over)

