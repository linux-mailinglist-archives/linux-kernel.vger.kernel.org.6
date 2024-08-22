Return-Path: <linux-kernel+bounces-296836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 669C995AFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114931F2236A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1DC15F404;
	Thu, 22 Aug 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U36xourh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BB157A6B;
	Thu, 22 Aug 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312972; cv=none; b=nJaLdwYEEWDsXCQVAVGquge9AX2PUALy8ICjqiuytSxGyGDKvJw5kKhd1tMoiKI0B4fLR084/eqOum62jlAPsR+ebWIRxnLjJcErFA+8pkBdzbwuJTHgtT1xHT+AxBQAzT9d2KSrklehz9SyFz6fQXARmsPr1PHD40xSiNqGJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312972; c=relaxed/simple;
	bh=ra5Ua8K+PR+QUDhM5vj7FxNpsnhi8E7XUVyA+UHwEpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laD8/hGbxU7Jv/TLMkrdFZbDG7uvs0MlCu9NhFFgP7VIexcVLMuA/JfyL5NPw66bApHj9i9cWzr99Exo59CcrlKEpBh0dm8THONF/0S4nQ/dDdjHD1u6Tf4KhpUl2dwkgFqGt/Gd0wIq4BP3A596at9pHG7UUdkO6cQmHjpP65s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U36xourh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27956C4AF0B;
	Thu, 22 Aug 2024 07:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724312970;
	bh=ra5Ua8K+PR+QUDhM5vj7FxNpsnhi8E7XUVyA+UHwEpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U36xourhuAVQB0tdaraNntO1E1TtZQh+P5P9SKH5Gt3IBECyhBQkGR0J4ftamcl/4
	 G1OF2EQXRIGIgV+1k4cRMFmyatVZOeG0TE5bE4jUfDgJI+iItK4NTlgtxrUKqlcgb8
	 Xz9MzFl5cvS9rHnUfZoNgh0bbVrjCjqLLW8ko6h8=
Date: Thu, 22 Aug 2024 15:49:28 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gabriel Maciel Raad <ffunctor@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] Staging: rtl8192e: Fix parenthesis alignment
Message-ID: <2024082253-duration-esteemed-a057@gregkh>
References: <20240822002346.3555-1-ffunctor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822002346.3555-1-ffunctor@gmail.com>

On Wed, Aug 21, 2024 at 09:23:43PM -0300, Gabriel Maciel Raad wrote:
> Fix parenthesis alignment and unnecessary blank line in
> rtl92e_leisure_ps_enter to fix the following checkpatch.pl warnings:
> 
> CHECK: Alignment should match open parenthesis
> CHECK: Blank lines aren't necessary after an open brace '{'

You did two different things here (and one was not mentioned in the
subject line.)

Always do one "logical thing" per patch, this should be split up into 2
different onces.

thanks,

greg k-h

