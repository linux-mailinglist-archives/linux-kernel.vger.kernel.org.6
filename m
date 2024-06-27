Return-Path: <linux-kernel+bounces-232780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF591AE35
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EC71C20E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC721A2FA1;
	Thu, 27 Jun 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tTiorXtG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DF1A2562;
	Thu, 27 Jun 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509613; cv=none; b=otTD8Vv+aCVkOdFqHpnQwBoCHTNhTIVEHIfI2AAh2FCQZuo82qo8ARHM2TuBYGyKR6LVbL4fiG8WVS8wtUhWnGHfuHfH7f3lwrwguzDljuHvDLu2WXjbeaGdNnF2kWEFnLT6lti/MRAC0s4+yJS76rewb1JldTA+OWIVd0wM23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509613; c=relaxed/simple;
	bh=/JDFP9n6PGo01QXfypchoElbcwXuKjpkCu1BCM+9qoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EVBE1rJvF9HvPAtGcvlcJ3d8RdzsD9eRzvfeSnLQtCeTODJn5cjspZ1YjKn0+RYhICn0kvHA+SusCCgL6CEDQJ51jUfbgq5PIevSzD0inEEb9w5yvUQeya0LP+v/jKMalJP0pGdRmpMLlFiFTnFGEZXOkaCkMkFcKhSRlfHvGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tTiorXtG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F05BD45E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719509603; bh=/F0zoivBxY/yAFf6EizQZgWTamhqaIwwJLXJPsffNqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tTiorXtGomA4x7G2OjLDGPpYeHkdD4jyTMsnz9pXdnT/u4wPtCLB/Lk828aZkEOVB
	 wxSKf5UGbSovb/OXApOzV+a34NsDkKJZXnbaU3htbEz9/nYT2cnc3PdwdRqPvZLkJB
	 T4b4W1ExvU/Q7/sg/yEpAYCTTRkaEa6oSH5Z9avN7kPynPPu7GJjte+MG9yCrlyqLt
	 IoZHU4DxBTcUMvtsVCaQa8qXIL1IhZsNQ1snnRaH5OP+Z3NgZa2+mns7ApkD1aezg9
	 z5GvpW+1bkVdemNuMqwzmK0DFHRJzlmCDxmMn7xUrzMiQDVUbzhPixcejXEaMXIv2X
	 VgMmUhHa0LjYw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F05BD45E04;
	Thu, 27 Jun 2024 17:33:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Remove IA-64 from kernel-parameters
In-Reply-To: <20240627162458.387700-1-thuth@redhat.com>
References: <20240627162458.387700-1-thuth@redhat.com>
Date: Thu, 27 Jun 2024 11:33:22 -0600
Message-ID: <878qyqwasd.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

> IA-64 has been removed from the tree, so we should also remove
> the corresponding kernel-parameters documentation now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: Patch is based on linux-next branch (which already contains
>        some other patches to kernel-parameters.txt)

That can make it hard for maintainers to apply; it's better to base
patches on the tree you are targeting.

>  .../admin-guide/kernel-parameters.rst         |  1 -
>  .../admin-guide/kernel-parameters.txt         | 45 ++-----------------
>  2 files changed, 3 insertions(+), 43 deletions(-)

Nonetheless it applied just fine to docs-next, so I have done so,
thanks.

jon

