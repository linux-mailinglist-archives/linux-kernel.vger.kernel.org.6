Return-Path: <linux-kernel+bounces-385977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E499B3DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633E01F22E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907A41EE011;
	Mon, 28 Oct 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIy3Izsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6AD1EA84
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154468; cv=none; b=s3aR9cE3arS55LorENopmEZsTs0dEf8kKCTf3VZcef2EQByBM7hiONJ2S9Tt3wb0tSk1e62FTO5SFA748RaaJYVlxtR7roJ+zRUFpkGcskPsZjZV4GYrTLP6j93Qd3YomPknYnPDYhVjFdIBrX80bwrDnMZoZCeOzpVcBixINHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154468; c=relaxed/simple;
	bh=Jvdt+FBhaaVmJ003H28xApvehRt6kZUcV5/HI6Mt0nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4TZpwcZdcD5rn+75ie7xxhZsK8Ymh6m3R8YhLDpBS3NWaDSmIHZkJ9zXABp5Sasvbm6vrGARxENhhYGTOuh46RUqaDsBhNlLyoIatvQ6su3WZnN3a3LojrO6XSg917l4TipytX4ySp0jwY+fXhYYrQ+tCck9i+Kr5G9Fx9ePdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIy3Izsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EA4C4CEC3;
	Mon, 28 Oct 2024 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730154467;
	bh=Jvdt+FBhaaVmJ003H28xApvehRt6kZUcV5/HI6Mt0nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIy3Izspz31m/oaQVrRyYDXiqdqO5Mh9dzgX2f/u7uZwf06uu6G6rGC46pJZO97cw
	 ScntBMf+29qaKI4lLKr1xWtgavJmwZgScdUA1Nhyvc3ZLo3HJmm/1fNFgGDvmMbUEC
	 voWRXzpKvRSFJG2BOUUvoEzQBZTZHcSTLTvLTcT2AKlcMsjqwJ6SIKusRafHvFbLet
	 An0Rhke9HhUbFM7if/cc3AcUND12bPaPt6mBpiZuSSGat61AIISUNM65x8V53QQNLI
	 Dz3e8/y9namgGyRaSl32DwGsl6LEwjeAON3ICp0BrpFoi5nzpjHHZO1hNY+gugjcnO
	 VEH0SrF1tP5Bg==
Date: Mon, 28 Oct 2024 15:27:46 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kallsyms: add MODULE_DESCRIPTION
Message-ID: <ZyAP4sFzpvQRKVlN@bombadil.infradead.org>
References: <20241028163000.2201045-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028163000.2201045-1-arnd@kernel.org>

On Mon, Oct 28, 2024 at 04:29:54PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added test script creates modules that are lacking
> a description line in order to build cleanly:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/module/test_kallsyms_a.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/module/test_kallsyms_b.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/module/test_kallsyms_c.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/module/test_kallsyms_d.o
> 
> Fixes: 84b4a51fce4c ("selftests: add new kallsyms selftests")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied and pushed, thanks!

  Luis

