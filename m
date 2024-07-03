Return-Path: <linux-kernel+bounces-239564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02AB92622E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5641C21CEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B793C17967E;
	Wed,  3 Jul 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qAny1NVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D961DFEF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014585; cv=none; b=SWGbL9u0JfqnnW2Q/5CPDFA9qS3lwZVIlFFGhBYh94YbN+QZ+RYo6J0CCNyIzTaDL5ttX1bQBUhD2RO9zF/TdlOSgAxrqZFNBy9KLU8aBWCiEAVax48xajan6q8FZFGlhwgwr3+6LQ2/axbVZzCmuTiwJMsHNObcck/l1FDJIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014585; c=relaxed/simple;
	bh=yfG1Lz4pK+dFCpKvqdy/MfVhi89WaI/JT6wPWZbrjio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU08Wu0Mtb0b7yNLEzozS3O8g/5yPbDNMfEjmlPDTXL0jq34T+2IAwSKOt+x43Wxr1yip9Mtkkeq7QUg515rWPZAfKAt1Ewd9ww36XJpapP6i59hfurzgXTtGE5vsx9k1Rnl479k6eAT573w4dYbVCwOhQsotzpKla+GviAe7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qAny1NVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF54C2BD10;
	Wed,  3 Jul 2024 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720014584;
	bh=yfG1Lz4pK+dFCpKvqdy/MfVhi89WaI/JT6wPWZbrjio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAny1NVDiVk6k4k+5nDz7JeWl8lJj+1WO+okFW6MIT/RgQ7xwOgBmLn2PxU9yUK7e
	 xg/jaXBZsZaKadOeErfbVeWm+Yd+dLKpV3QTX5mCGbM8bXDXEOeMyTsHZh8FAeq0cs
	 +wjEqLcObJbgz9ge87IFELX75N1J71fJvr0XztJY=
Date: Wed, 3 Jul 2024 15:49:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL] w1: drivers for v6.11
Message-ID: <2024070331-output-unloaded-85dc@gregkh>
References: <20240702071459.9436-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702071459.9436-1-krzysztof.kozlowski@linaro.org>

On Tue, Jul 02, 2024 at 09:14:59AM +0200, Krzysztof Kozlowski wrote:
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.11
> 

Pulled and pushed out, thanks.

greg k-h

