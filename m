Return-Path: <linux-kernel+bounces-397021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466979BD5B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B771DB21A89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03161EBA09;
	Tue,  5 Nov 2024 19:14:01 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DC31E2007;
	Tue,  5 Nov 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834041; cv=none; b=ddtVsXJfsJAbjV6jyS5w1W8YvZFppS8WBvyF9RCgeKWgqDN2caBm15qQqamcnf+DHpzik0BiQOebAnyXBk7LdPxGrBbAGHbUR4ptles8eVVt5lw0c4gl1dWy7fxsMyIU6bwj4RLP/adVg+gYG9ihYJSznAp6lwUIS/N2LWhH8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834041; c=relaxed/simple;
	bh=GxRkPVNTo/Eo7usfPhaWFX2tMZp/ZaS8VV6kFyVG+m4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jp6hfiyjnE/GoHBGVlwPVJfg1JG3DldMU2zspzbP4mHVHhuU6foAmBi49+7YaoLcIn1gVGXsms7CwXRvytCihCZQxh95Cd1qU6VaZP8uqChjN9TmW/5vXGMU0QvXmet7lIKju8Pz9jo87GKYCW8KJP9SHaBMXDlnNm9ymO2gLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8165392009D; Tue,  5 Nov 2024 20:13:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7D3EE92009C;
	Tue,  5 Nov 2024 19:13:56 +0000 (GMT)
Date: Tue, 5 Nov 2024 19:13:56 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: kernel: proc: Use str_yes_no() helper
 function
In-Reply-To: <20241105173837.37756-2-thorsten.blum@linux.dev>
Message-ID: <alpine.DEB.2.21.2411051911550.9262@angie.orcam.me.uk>
References: <20241105173837.37756-2-thorsten.blum@linux.dev>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 5 Nov 2024, Thorsten Blum wrote:

> Remove hard-coded strings by using the str_yes_no() helper function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>

 LGTM, thanks!

  Maciej

