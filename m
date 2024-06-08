Return-Path: <linux-kernel+bounces-207038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58499901182
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F93B21886
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D99178374;
	Sat,  8 Jun 2024 12:54:22 +0000 (UTC)
Received: from hop.stappers.nl (hop.stappers.nl [141.105.120.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39573176FC0;
	Sat,  8 Jun 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851262; cv=none; b=n7OFLbXJOwxo5HTa8oFJs6SeyohiJ9KOQILS8wS5TyU5gNnxlnEBpJx4ea4dANdMRbHywMHv6HzQCx6iP/Ggv2Ub6ImakWYRS9We5sZCDHNAif5VgB4plzb8VIEb6Kksx8K6nyxa4Dak6gvIehqu+esxEhLAIUUhL6ualx4YHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851262; c=relaxed/simple;
	bh=Jpx/+HGoQT7FfdP9UmOZYjW7RwlxvVsAXIw5WWqoBI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyDExHV9LFvBk0zhEH/Lk0Fs4H+3g+7aUkDzjhJqfJ00HceAcl4Wvlz5wPnOGoGnmWhjZImxBpiR+C6kG3t/dnfdfGbLc/P276eSZv7TEVbp4t86dud4ubuS8e4bhAspCgmYzidq1Yfa/I47pOi1JryzSofANHZJJI6tZJpwaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl; spf=pass smtp.mailfrom=stappers.nl; arc=none smtp.client-ip=141.105.120.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stappers.nl
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
	by hop.stappers.nl (Postfix) with ESMTP id F2B2D20219;
	Sat,  8 Jun 2024 12:43:01 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
	id 47AF730417C; Sat,  8 Jun 2024 14:43:00 +0200 (CEST)
Date: Sat, 8 Jun 2024 14:42:59 +0200
From: Geert Stappers <stappers@stappers.nl>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH 1/1] arm: rust: Enable Rust support for ARMv7
Message-ID: <ZmRR0yuqgVd50xXL@gpm.stappers.nl>
References: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>

On Sat, Jun 08, 2024 at 12:30:12AM +0200, Christian Schrefl wrote:
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -286,7 +286,8 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
>  
>  # Derived from `scripts/Makefile.clang`.
>  BINDGEN_TARGET_x86	:= x86_64-linux-gnu
> -BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
> +BINDGEN_TARGET_arm64:= aarch64-linux-gnu

That white space change is probably accidently.


> +BINDGEN_TARGET_arm	:= arm-linux-gnueabi
>  BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
>  
>  # All warnings are inhibited since GCC builds are very experimental,


Groeten
Geert Stappers
-- 
Silence is hard to parse

