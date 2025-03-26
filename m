Return-Path: <linux-kernel+bounces-576741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB0A713DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754011887059
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B851A5B94;
	Wed, 26 Mar 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifqv2Mdx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8F13D539;
	Wed, 26 Mar 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981932; cv=none; b=B9iQrVPzA1mYx/Qa1ljhd9J6X9WIU3sAuhpwNJ/3/40i4KI2WRQHLn2nsP7oVYXL/N1okaS6KnmDrrwF/65p/dfi4JH2DlXtb5++HwA5he5kGPSsQ6SN3vN7i9jW70v/IHBfZH+tATXVmcd6L7yZQrNPIJlxTiKKaCTfRz1nD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981932; c=relaxed/simple;
	bh=G6UbKjsg9joraVPAmFvugruvd+PtNhFl3BmnBmylux0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd+x2rFN540AalkukSQuOP86Sx+c2KyI2bkNYoLKxR5frOKDUyt3FpiFaRTSoqF3axDTqjzWZaCd5aolafEONf+Y+EV7rMb5crEsxHVUtyhtLCWquONaYRcBq8eqBPYg6jpDVWUUrhChdfZEZbfmPD9TLqg9wMsgX7B4iB7Rhb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifqv2Mdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7451C4CEE2;
	Wed, 26 Mar 2025 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742981931;
	bh=G6UbKjsg9joraVPAmFvugruvd+PtNhFl3BmnBmylux0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifqv2MdxBUU67/TW5gV2dsD5l1PBiRob5ltQZqjEWJxGX3rd6KooeElqfaAbOexXX
	 r5FrCMLnpyjsYMixwkZdEPL9QrUKYBYlZLL5R1+bxlcfzCsz9bH/kGIeJkNTYW6CHx
	 SG/lI9bQV1DYjj75ebX04NsZ6LGDadVN4V1LUom8UzMRoXg2R2nYTUkrcIODyCCSsF
	 ExR+MLmaoPl4uzIPuIaoT+NUZrnzUWUyXiH4NzJmX4isqfv5UxPxjybLXgxPb0L/os
	 UT/PqUqB0VPQ6yNRDXYYkNOhxNpUZaW87ICFhu8kGPGcHN4VBsYJSfwsq6ZgpT9L+J
	 AceSW6wzK9GsQ==
Date: Wed, 26 Mar 2025 10:38:47 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] platform: cznic: fix function parameter names
Message-ID: <l77cp7hlskzkauoohviwonal53upcyc74j7x57ycn7sdfkmu4f@fsm4tv2lbtn6>
References: <20250321085315.915808-1-arnd@kernel.org>
 <20250325155906.GA1886499@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325155906.GA1886499@ax162>

> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> You will be taking this I assume?

Arnd already took it into for-next:
  https://web.git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=for-next


