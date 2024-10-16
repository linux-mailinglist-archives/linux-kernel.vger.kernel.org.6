Return-Path: <linux-kernel+bounces-367573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274E59A03FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC3D1F224B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85741D2708;
	Wed, 16 Oct 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V14iYbyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D01D1F76;
	Wed, 16 Oct 2024 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066644; cv=none; b=cIcC/eeKVg3QO9YAQosPrCqbN5YywGCEBGApYCtGT/zOvI3Sq43spzhuMmb5P4DYSVjBums1UulC+HuRy6pQvgEqfvbIV+ne63l9BdsKIv/7TQWsJiH9hsT1zSbE55oPIFfjUMz0BeqdLq/vdlXFLVj1PVNclwgeGBBWPi23Mzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066644; c=relaxed/simple;
	bh=slQ1CsePUocGdxLOVN05CLlnciiC/S735MVJqH32AP4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OWUuy0hCMro6EaTwvbgdKdS4CYoQ765swqa8vY+leXdNlv9RUiPXPinbgh9qHD60LvPRAp+vraLlpqypCg2cMbFBC8NEAn2D9fbLmUAU25zchKj6VfCavSh0g9oC11ruVEzEb5HurKPI1o3YSZAB1WgpfvPirQNp4JweersNac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V14iYbyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663CDC4CED1;
	Wed, 16 Oct 2024 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729066643;
	bh=slQ1CsePUocGdxLOVN05CLlnciiC/S735MVJqH32AP4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=V14iYbywtSzqCJ9TVUmaVcaT52mT42Wutosp5DDeVNFQrslT8zTUEzeys5m5grHHV
	 vEKQCLU+WGZR9d/Y57kBkliz1vmvPhmX7Ni7h+0n7AcklDBfJDiq8nHAMuHcrrbhUp
	 DaeoLG87pQR6PefyfUvYvw8UrqNIkdSmDD3fGT3Qb0JcqyfS+gJLWmDNFW2/ARl3T0
	 TdQtdZAx7xHM/PYgBXhO96F9mlAcreMmi7Em+8ew4wMwTAoFb/3qhBbPHgS9A3xvsQ
	 CIn3a4Mpahs7L67sPsIOZQQkpI+qCqfZMuz65zqMWzYD0ocNrs9XPH1TfCd1gDg6Xb
	 80uo2MK03x1gg==
Date: Wed, 16 Oct 2024 10:17:21 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
    patches@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] HID: Remove default case statement in fetch_item()
In-Reply-To: <20241015-hid-fix-fetch_item-unreachable-v1-1-b131cd10dbd1@kernel.org>
Message-ID: <nycvar.YFH.7.76.2410161017120.20286@cbobk.fhfr.pm>
References: <20241015-hid-fix-fetch_item-unreachable-v1-1-b131cd10dbd1@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 15 Oct 2024, Nathan Chancellor wrote:

> A default case statement with a bare unreachable() was recently added to
> fetch_item(), which by itself introduces undefined behavior. objtool
> points this out with a few different warnings, depending on
> configuration and compiler:
> 
>   vmlinux.o: warning: objtool: fetch_item() falls through to next function ...
> 
>   vmlinux.o: warning: objtool: hid_open_report() falls through to next function hid_parser_main()
>   vmlinux.o: warning: objtool: hid_scan_report() falls through to next function hid_allocate_device()
> 
>   vmlinux.o: warning: objtool: hid_open_report+0x21b: can't find jump dest instruction at .text.hid_open_report+0x40f
> 
> Replacing unreachable() with BUG() is a typical fix to eliminate the
> undefined behavior and make the default case well defined. However, in
> this case, all possible values are enumerated in the switch statement,
> so the default case can never actually happen, as proven with the
> comment next to the item->size assignment. Just remove the default case
> altogether, as the return statement would still be valid if the switch
> statement were ever to be skipped.
> 
> Fixes: 61595012f280 ("HID: simplify code in fetch_item()")
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Closes: https://lore.kernel.org/20241010222451.GA3571761@thelio-3990X/
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Closes: https://lore.kernel.org/fe8c909e-bf02-4466-b3eb-0a4747df32e3@paulmck-laptop/
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


