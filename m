Return-Path: <linux-kernel+bounces-327242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD79772BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6A81F24E23
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0701BF7F9;
	Thu, 12 Sep 2024 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me/xbB+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB413CFB7;
	Thu, 12 Sep 2024 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173124; cv=none; b=VktSKlVJy3V9e+dUbaJc+rPkQpl+d0dmqAj0KVNpMmNZHorEN5YoSB7+7b/NWs890pdWFVDSbtNoSTCs/cLXRbCLghTEZB3vC4TXmsOlh8xC7i1uIkNVPU6GtEQ8+RT+ZeNqrfiayi7fjXvnsTUPL0kY6UNnUNA67TbNGoWZRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173124; c=relaxed/simple;
	bh=TbyE6YLUJEXuDAtJP201235txoxOj26ezN6mlc7lzcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyZivVYUk6HxJMjx6NAoHP8zHbaVOzMGJAJ4yO/lJcXiGdt0wXaH9cJpUjQPcGDLGRzSi+GV1T8U/K4/wq7ghIq/zhbVxbIRT5kWc/3r4Tinrav2QwMhViIHMLjdhV/srqLxZHxIXi1TIidiACa8IQcJd3UbZ8PXPvZIgGzfxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me/xbB+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78DAC4CEC3;
	Thu, 12 Sep 2024 20:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726173123;
	bh=TbyE6YLUJEXuDAtJP201235txoxOj26ezN6mlc7lzcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Me/xbB+kWP3eP/hVjN4j2Z+4jLqw58b6rExLPMbPlYWsgTcwvTkCLBHUzqwn85vJv
	 VZicjLsWLmMVr0Y0Wd3PqMgEGMKAd/WQNvLzatKBY6xzAThiV1o88yYajQoPGrGWOb
	 MkscFq9EOzhxZHu4Yl5ZgqnAEHTulhmfNYGj3Cp9WeebksoxsPss2+1EAmZmCX5UgG
	 ibUvdxn1iNH6nw49BuPtZR/csmSNfOsUh0H3xEWkH+D3sgJNXxN18kYNgvfCnQNTIN
	 rpvb5VxM3wU748I+wGO3zlcHpiMUeOsm9ZE65XkKDe+kS97JgywTpe0XeTj37RJ89b
	 OioCkRCQzaWJQ==
Date: Thu, 12 Sep 2024 15:32:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mikisabate@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	saravanak@google.com
Subject: Re: [PATCH v2] drivers/of: Improve documentation for match_string
Message-ID: <172617312190.738061.4164864853737783773.robh@kernel.org>
References: <20240911204938.9172-1-mikisabate@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911204938.9172-1-mikisabate@gmail.com>


On Wed, 11 Sep 2024 22:49:38 +0200, Miquel Sabaté Solà wrote:
> The description of the function now explicitly states that it's
> an *exact* match for the given string (i.e. not a submatch). It also
> better states all the possible return values.
> 
> Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
> ---
>  drivers/of/property.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Applied, thanks!


