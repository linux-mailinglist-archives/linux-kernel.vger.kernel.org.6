Return-Path: <linux-kernel+bounces-294478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D8958E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8568428563A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DA514B097;
	Tue, 20 Aug 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3hXKug7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC88148FEB;
	Tue, 20 Aug 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179372; cv=none; b=dAa84HM+enuZJt1CKRY5PfMLSHaCAHB8EVB89IKUEncA8IhCc/r0jLmPDgsXcBi/jVctwKVuv4olSuR8NQp458xGdhX1w+RxGC4qYGs/JS8V1gLGNtqqa+bbukHVRP41YCJw0xb4rENl5+urDw4EdrKbkwkTwiEaC3st+gUP610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179372; c=relaxed/simple;
	bh=Bu4c9AqD93+rYGRI4s9S5LuYTm/5wtsdqfTovtuNV1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeryDgc6zvbI+o2MEjD5p1cMYRbWpRng9+7H66EaL7/L8s6fGAAtHGt2C55tlI/rBnLbuhZwsZrpcGlKYxuOi5PMdzzD2owyJIQ9n0BonWG77OkYmAq5Hvrrzw3fwNktCZMnGndSV/c0eJ8eaHaFnGQ1JhTCOUz8smZXjFGIKQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3hXKug7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02970C4AF0E;
	Tue, 20 Aug 2024 18:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724179370;
	bh=Bu4c9AqD93+rYGRI4s9S5LuYTm/5wtsdqfTovtuNV1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3hXKug7xsadqgVNVvvkeBIzhdEviDNhhcXFIKs5rt95v4dxGE6kk2d0QWIXJaT4T
	 MRkRAvNfp41mrIIphsIr291EejkAXrU3qaDOWs5t0UVyYKLacnWR+RkPGc5Hdz7sxI
	 2dY62zBRNw3DS/s/p1hbVxXhLEdR1+q39/2GIGh5iwtoZXNXVUYszbTfOtNpcpwZdR
	 MtDpTw9zp2mAlTAY3A9i03Ue6fduZzFKvBEATiUs+rkpsynSPIfmRrNAQn49Bj6H9w
	 Tt6LuokNzskLimrNibjgR800+LuoWrwMghLMIWgMS1qgQz+ReH/RaUa1Wt9jJ1dubF
	 nLlRPX6O49CnQ==
Date: Tue, 20 Aug 2024 19:42:46 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nfc: pn533: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20240820184246.GC2898@kernel.org>
References: <ZsPw7+6vNoS651Cb@elsanto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsPw7+6vNoS651Cb@elsanto>

On Mon, Aug 19, 2024 at 07:27:11PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Remove unnecessary flex-array member `data[]`, and with this fix
> the following warnings:
> 
> drivers/nfc/pn533/usb.c:268:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/nfc/pn533/usb.c:275:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


