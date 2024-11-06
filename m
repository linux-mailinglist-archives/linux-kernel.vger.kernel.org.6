Return-Path: <linux-kernel+bounces-398314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C432F9BEF77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889CD284FD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8431F9EAF;
	Wed,  6 Nov 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMhpwrQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C471DEFD7;
	Wed,  6 Nov 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901104; cv=none; b=eXeDbgAHi4pNCAgt1pEheo/NMYm/MZodn6Ns4ZWUY8p7V3ZkhzdnSiJJlgtxqZBffxHoFvSpFgZWkT/9Mhlo7HLhlE3J92J6GGAEA18IzKS4rSV7QMcwS1m2lPcfz1ufB3Luekb67WGy1jnlLLfMj5sYLPHxPCMHTFJ/VIXVr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901104; c=relaxed/simple;
	bh=0Vk788ZZKXNB38TEaQ2/NFObChD6O7+6oKGX1QBRcBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWdrZORxKWnCJrlGK6yVUVVKmrstpi9c1zwi0doiD+fuyxtqIRdXazYKm9iglbsz4T+yth+wQWfWMr4X/ri2SWvS5HfaqlCyfuWuqG40iZoxjRK5WfCCpbZl36LrwaSZ8PI/42JRz9nBrYNtIMSindPhwVL6cMFEP3N59DjcrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMhpwrQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A77C4CEC6;
	Wed,  6 Nov 2024 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730901103;
	bh=0Vk788ZZKXNB38TEaQ2/NFObChD6O7+6oKGX1QBRcBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMhpwrQXr0qbUqr7dg/U4WJirNO0XZf1/26P95vZDOdS8dCAFup8gu5zP3Nmz7gna
	 6hicyj5Ps52RCkBEE01wigSpU6qu6YLjjxbXvzONmy91HC+92F5eFnmHM3WjfjR9gu
	 UooJ/sUpEGenL8bLgiBz1TFtxH9W3jH6dZ1kwwHMeVPM7bFTFtYgIiq6f3hCLbOEo5
	 JtRme90fSWrM94fAj6XnogC50If2SBA7KulUJ0XCcnowjAWNitg+3vd2GblSwdHb84
	 3xXQm0UqnnvdE8QAz11L+kMwe0RXbhmCdlONld379CXi51UF2qKThxEom4WL61kpFH
	 AWRzX7cLtKLrQ==
Date: Wed, 6 Nov 2024 14:51:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] This adds the schema binding for the Iron Device
 SMA1307 Amp
Message-ID: <a2cmjydyryfm3fgqgyun4e352cbg654yba7ggzavatrq4dvrd7@f35gxk4cgi3g>
References: <20241106004621.7069-1-kiseok.jo@irondevice.com>
 <20241106004621.7069-2-kiseok.jo@irondevice.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106004621.7069-2-kiseok.jo@irondevice.com>

On Wed, Nov 06, 2024 at 09:46:20AM +0900, Kiseok Jo wrote:
> Signed-off-by: Kiseok Jo <kiseok.jo@irondevice.com>
> ---

Missing commit msg, missing subject (so commit msg went there).

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.


> v3 -> v4
>  - Modify to fit the character-per-line format


Best regards,
Krzysztof


