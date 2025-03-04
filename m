Return-Path: <linux-kernel+bounces-545041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31641A4E880
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936D88A3F48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBAE2980DA;
	Tue,  4 Mar 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="P5d5wjSU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C52512ED;
	Tue,  4 Mar 2025 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107138; cv=none; b=BR0SclqAtN57Nm5b5oPAbdXrhYbp9sdSj7RBE2QQJpxqjuPTtqk3PjKe+UT+ctlXZ3PcD2kz3qNtjcfhBgc9jVveFsQaplTUdghK3+anPDgC2WuSfhueHRo1fkzesBHyyAiJPYsoorkFUaBAt4u7Ekk0hNHne1ppw2DMW2Pcx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107138; c=relaxed/simple;
	bh=v1VtBn8l9On52tRusrkxsGj14qADlg+dG3UjvkhkKtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X+3MeoUIISFyYfb6hYgfAyWxBoTVgzyqcb/yTyoQ+6E9c7n8VoPDQrHekn7ynPtju9fUcZ/IXfZxFpslRieF9APQziWHI7mTKJanEGIuhOQ6ze34n9boO8HnUI6TZjDnDfjhnpJITEiLu1sDrf2b8pE0MqRqQzLdWlFIERQF8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=P5d5wjSU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B46DA4105F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741107135; bh=v1VtBn8l9On52tRusrkxsGj14qADlg+dG3UjvkhkKtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=P5d5wjSU0aFmcx7Fy0G+3RC473d7Dr3RUUNl7YfR8X0ZBb4Kbd1oSps7p0gj4tJ1O
	 7hg+Uds48FvETxqLjn7JKbI+vVpnB39Tq/HbZYrlxaFbmmZY9SGo/a+nJsOYGX8jsx
	 kCPh3MKdqQo/ao68BGcFLRhKTmHKJ/pUd9exZSK2PMbChzToYUkhYYRRXUde84vub0
	 44XpNtHoXxSTRpbcZ8ySxxKMJ2m8Uft08HLXbglsl6+Nw4USiZZgCfjxYd/RclfrhU
	 WgOqkO/FmcK7cGcKOvYvfGUgY2uqQw/t6yoM0MKvux8KnBm89pAdTMprsCPGIeuZym
	 eQIbFPgFRjspQ==
Received: from localhost (unknown [73.243.92.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B46DA4105F;
	Tue,  4 Mar 2025 16:52:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/39] scripts/kernel-doc: drop dead code for
 Wcontents_before_sections
In-Reply-To: <174a15607fd057c736dc9123c53d0835ce20e68b.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
 <174a15607fd057c736dc9123c53d0835ce20e68b.1740387599.git.mchehab+huawei@kernel.org>
Date: Tue, 04 Mar 2025 09:52:14 -0700
Message-ID: <877c54eo1t.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> There is a warning about contents before sections, which doesn't
> work, since in_doc_sect variable is always true at the point
> it is checked.
>
> Drop the dead code.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

I've applied patches 1-6, just to lighten the load slightly.

Thanks,

jon

