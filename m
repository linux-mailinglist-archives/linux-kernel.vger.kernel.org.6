Return-Path: <linux-kernel+bounces-565168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4025A66219
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EDD7A58FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0B204C35;
	Mon, 17 Mar 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sjGTpFcW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862E1EEA20;
	Mon, 17 Mar 2025 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252032; cv=none; b=Iqk576PUkrPc1zkt5QHEHOZn3IdZW4slAU2oJn4j8z3AW/tyvkL/X2+wBsGd0joptUM8ZmH8f+DgU3DTeQXmZ1yCc0jAAYuJfSznFNCs2hsGzBr8lNTi3mdo80L/XcNvURA1EROPJCV70OrIhqOr0YPFbtJqRtYnTxY9XNH/txk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252032; c=relaxed/simple;
	bh=1S1wcpOAxOJ4DHTjH1VO4jxPlklt6ZOU7On+F2Rgyjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RXxRN/iZ5C5vFHbx8N6FzTILG/bESEVJvQrYNdWsGjV08iWedGoAeKGv2MaiXh9xxD1kb3Zw+ty8DIsddS8eIG+QBug19M+Wo4iVKuGc2SdDG6Vs5I4B7GdA+xM3qHSOHqYEltt59CjyhMyqw26M+0ZHNb9l+ZdELN2bdsAh0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sjGTpFcW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CA02E41081
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742252030; bh=m1ArYPexXQLLtsttigae2e4aJ3hQRaLakaXfUFdgBoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sjGTpFcWrFNyxcrEhg5znWVSCMX/Jxov0q9Ugh8gtnqqZboBDzXiAlylqrhRY2zi1
	 cyIGLnkpswu+aJtUY2TZFzVxJp5OtmTs2P6lw6wCWVbxIjHv9FM/b8k656bRWLHLaV
	 IuhbgxUjA3neuEQ3ZllosRbua/ZfRVTLxtuJzGbPskBFHH+A8gwLanTpL4YSk5Rnhk
	 xKToCE+f5fDf2QwgTp9qiWfUyAm1N7yKJA7tJq1AlBPoNPjGlJG83tN41wUr7ewT3Z
	 P1JXzlHeb8updjN+8+EUEZwreC8NacJv2vgz5hPP5DZ+bfIcUze43tjUudxE7PLO28
	 j0KiF4vKWTBRw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CA02E41081;
	Mon, 17 Mar 2025 22:53:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: Re: [PATCH] docs: driver-api: firmware: clarify userspace requirements
In-Reply-To: <20250314100137.2972355-1-jacek.lawrynowicz@linux.intel.com>
References: <20250314100137.2972355-1-jacek.lawrynowicz@linux.intel.com>
Date: Mon, 17 Mar 2025 16:53:49 -0600
Message-ID: <874izre0aq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com> writes:

> The guidelines mention that firmware updates can't break the kernel,
> but it doesn't state directly that they can't break userspace programs.
> Make it explicit that firmware updates cannot break UAPI.
>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---
>  .../driver-api/firmware/firmware-usage-guidelines.rst        | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/driver-api/firmware/firmware-usage-guidelines.rst b/Documentation/driver-api/firmware/firmware-usage-guidelines.rst
> index fdcfce42c6d28..5f8f13e2ee510 100644
> --- a/Documentation/driver-api/firmware/firmware-usage-guidelines.rst
> +++ b/Documentation/driver-api/firmware/firmware-usage-guidelines.rst
> @@ -42,3 +42,8 @@ then of course these rules will not apply strictly.)
>    deprecating old major versions, then this should only be done as a
>    last option, and be stated clearly in all communications.
>  
> +* Firmware files that affect the User API (UAPI) shall not introduce
> +  changes that break existing userspace programs. Updates to such firmware
> +  must ensure backward compatibility with existing userspace applications.
> +  This includes maintaining consistent interfaces and behaviors that
> +  userspace programs rely on.
> \ No newline at end of file

This ^^^^^^^^^^^^^^^^^^^^^^^^  is a good thing to avoid.  That can be
fixed up at apply time.

Dave, you're the only one with fingerprints on this document; is the
change OK with you?

Thanks,

jon

