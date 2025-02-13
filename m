Return-Path: <linux-kernel+bounces-513512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64DCA34AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9894C174695
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C173F241693;
	Thu, 13 Feb 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Cl2Mkojo"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254920127E;
	Thu, 13 Feb 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465379; cv=none; b=Oer7WKI8UhntfeYgQQhsdYvtmqrWYgQGmULp58W+wYwX8mFosXRmawPAAvQP7pmKqiiTinqUPnaChixS7Mrns83wdQJOoTIMWYXFuS1ql3DUg4LoGsU3dLg0USyiolXGjYCqc8BvGBn5e3ZEuF4FNODVJcq+q4qXvQolIo3gQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465379; c=relaxed/simple;
	bh=XZFdXSDZD65LQDfFjUYMN9YhaLCPJ8HiAADczo3eFKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ioLAvSV5LFTYWk82yyttbhNYnOSPPkN+B5NPUVSEP0HHk0moAUdh5YQuUzV0TdANrQqLFTIwrdHM6dJzxriLSRDnTorhc2bvgl873KtCQjgTuKTk8wBRQJLaZpKwomSWCJ1QooysrsEZdFQ6Gm9Y1VuD59w2UOVhTtR0jcBR580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Cl2Mkojo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A459544097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739465376; bh=yrOIPhsnUA16ds7WWiuUHf++JbVHGw/nRwhO1ZfcWlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Cl2MkojoSSGJs9mShAvkHJqbkFuhvw1dWmckxx4SIuXNKZ29OxOXiJptX8OG4eks2
	 44U56Y8c93MtAEIrA13NY8zUs4piDB5FqjuVf3dlUCxY63+QshHhZCTGDhpnMmmB3A
	 YGYwtJY57Cx8U2jVnvEN+MWEn8A8AEZJMXnUPUPciwWMwL3K6K8YuA/7XaKOtyhQ3C
	 /1alXCJ91upbwXdN7H1vTg8B5TThMP/ZJN2h7R7Obqx4h0YyV7a+H9XMy/7OlX5Okm
	 qko7WnEKbxf3WvaGu0ytk7K+EaREO+XXM+tHJZEu9N4PLLoAZ9HSEPEPWv7IVBYvO0
	 p2WRm24Ijc0Jw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A459544097;
	Thu, 13 Feb 2025 16:49:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: ABI: move README contents to the top
In-Reply-To: <20250211055809.1898623-1-mchehab+huawei@kernel.org>
References: <20250211055809.1898623-1-mchehab+huawei@kernel.org>
Date: Thu, 13 Feb 2025 09:49:35 -0700
Message-ID: <87bjv56b8g.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The ABI documentation looks a little bit better if it starts
> with the contents of the README is placed at the beginning.
>
> Move it to the beginning of the ABI chapter. While here, improve
> the README text and change the title that will be shown at the
> html/pdf output to be coherent with both ABI file contents and
> with the generated documentation output.
>
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/ABI/README                      | 3 ++-
>  Documentation/admin-guide/abi-readme-file.rst | 6 ------
>  Documentation/admin-guide/abi.rst             | 3 ++-
>  scripts/lib/abi/abi_parser.py                 | 2 +-
>  4 files changed, 5 insertions(+), 9 deletions(-)
>  delete mode 100644 Documentation/admin-guide/abi-readme-file.rst

Applied, thanks.

jon

