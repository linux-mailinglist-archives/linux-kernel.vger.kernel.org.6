Return-Path: <linux-kernel+bounces-394682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEE99BB2B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA3282A33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1E71AF0A7;
	Mon,  4 Nov 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqx1JFQs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D91AF0A6;
	Mon,  4 Nov 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718031; cv=none; b=Vf3blQNy7dytwSXbS6UTRvcIU8iSylRFsr2Lf502ZYNjJX996TwR8Liqw8EfAymdQnGzA9MrMmxiVgF4dj9m6/XOtOGpVHLlfFmrojSLJ7m1djzOQ3ujyINqQghLlrlaiH+HqJz6x3EfyqbmZlXXU9UvTOLS+uK9YMuVI17JWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718031; c=relaxed/simple;
	bh=6nmX+b3S8jCKaBd2TT1Kq6gm3xB8cIG2E651H7rkYjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4NChSgpdBPkdjY0o+adXK+hjZJdxW9cN6U/+X771rgkZPbKW5ApLxMZGLLbIYcnX7EjqMrf5h/YUB/uAmNop6mLfSwqLgPQs8+dSCovxEN4n3TLwBpLVithcmManI4NytT1brOiwJiLIQlocyNsw0xVQDGpsYb81MAhQEynOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqx1JFQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C25C4CECE;
	Mon,  4 Nov 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730718031;
	bh=6nmX+b3S8jCKaBd2TT1Kq6gm3xB8cIG2E651H7rkYjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pqx1JFQsNMax76wukI4F6tAYH2g5FhaqO39Jpf/0Vg1Jk/TzNdOArKcGaR7FsNu9k
	 AJsA+J01dryLYHUg9WX0Sk9mYG5M2NPgsle/Es4PIoRQ+gzvDAQyrhvv/ff3RbroM9
	 4CfNzb4MQAn+4vTwFy1EOYXYEPw8Er5nPGA3ZGkVv2pW35quno8abit6LpGbAkFj60
	 ZeUxHu6WsczJjg7UaKkVn/2AtdsGbeqSPDpzRK5lC+9dUhAq9msI6w/2XylDlnaVkI
	 WzUPZLKkmQvWrt3MeJd8xTACut0SsXjm21BDzrZwtg5N/O8fLNJ1dw0YOUbWE6bfBV
	 MHQR/Vnk0pOJg==
Date: Mon, 4 Nov 2024 11:00:26 +0000
From: Will Deacon <will@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/fpsimd: Fix a typo
Message-ID: <20241104110025.GA11157@willie-the-truck>
References: <2cbcb42615e9265bccc9b746465d7998382e605d.1730539907.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cbcb42615e9265bccc9b746465d7998382e605d.1730539907.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Nov 02, 2024 at 10:31:54AM +0100, Christophe JAILLET wrote:
> s/FPSMID/FPSIMD/
> M and I inversted. Fix it

inversted? Fix it

Will

