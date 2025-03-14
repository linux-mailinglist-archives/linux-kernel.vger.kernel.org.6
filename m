Return-Path: <linux-kernel+bounces-561791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A742CA61647
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9985C18985EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2921202F9E;
	Fri, 14 Mar 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="pm4irdM4"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6217202973
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969811; cv=none; b=shTzcJDoaGzj6WeG61yQH4qIPwyZuaGcCV9IkHuB4OOHm979NfpXvGsvP5Ca5toPycfBJ+BbxayvzCyTgqMEIprlU/dSqzEkeHpLE5QLqWMFUvzw27vRNC+GT7ZtaH+MvOrr51UdGYpUSm8zwB4yv1qUp6Qj+PgxxKXo71rZyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969811; c=relaxed/simple;
	bh=Rf3Y2t5DfgJzg/9Slo+edGTDwDk+9738sTXLJVoqKHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQjXW/6MRNFjK5bMaL4TndjeIADFTDpBUxDBtpvdPdZVfNYdvINda+Bf5hmfgJ6PdaepU7pNE1C5GArt0ZYj0C2xMyiHJlFmm7icqSquTOHsWRan7ckeOPlmVTGxwiBciFYcHMfd7roX4/w+GYMp1hjXm0B6wLAC8Vk4sJH+b7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=pm4irdM4; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <1d66a62e-faee-4604-9136-f90eddcfa7c0@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741969806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rf3Y2t5DfgJzg/9Slo+edGTDwDk+9738sTXLJVoqKHY=;
	b=pm4irdM4HR3MZn2jvYaJbIkFZV/erWWwNaBU55MuhJswE4dYlcLX7vjUBeCb6YNGArVQQ+
	Sc0suUTZpLwSxR7uSJK4BeB9+2z3uBqFw7BhRekSs9PgHssYegQn+OZm4j/bGGbVCx9aqC
	HDWUqk5vy7FuSWHbd7L+vK4cD7jmPyIiCcqxPMm+a9UKUt1n+/fEWnGSP+6zrVSdfD2K7d
	Yg8nStKg0/rQzVup9zMup/aGQC3gWl6hj3sYB+UIkJALyp3vuGb+O8kajmf3wnpzwcJOMw
	OWtnT+E39b28KqmGzP0UdkjlLEJe/caA3GOmUD0rCOh8J26MyW9A6j8fFFcEVw==
Date: Fri, 14 Mar 2025 17:30:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: kcsan: fix "Plain Accesses and Data Races"
 URL in kcsan.rst
To: Jonathan Corbet <corbet@lwn.net>, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306-fix-plain-access-url-v1-1-9c653800f9e0@iencinas.com>
 <87o6y5lvvg.fsf@trenco.lwn.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
Autocrypt: addr=ignacio@iencinas.com; keydata=
 xjMEZgaZEBYJKwYBBAHaRw8BAQdAYZxeXU5yoeLYkQpvN+eE3wmAF4V0JUzIlpm/DqiSeBnN
 LElnbmFjaW8gRW5jaW5hcyBSdWJpbyA8aWduYWNpb0BpZW5jaW5hcy5jb20+wo8EExYIADcW
 IQSXV5vKYfM26lUMmYnH3J3Ka8TsNgUCZgaZEAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEA
 AAoJEMfcncprxOw21F4BAJe+mYh3sIdSvydyDdDXLFqtVkzrFB8PVNSU9eZpvM0mAP9996LA
 N0gyY7Obnc3y59r9jOElOn/5fz5mOEU3nE5lCc44BGYGmRESCisGAQQBl1UBBQEBB0CVC5o6
 qnsTzmmtKY1UWa/GJE53dV/3UPJpZu42p/F0OAMBCAfCfgQYFggAJhYhBJdXm8ph8zbqVQyZ
 icfcncprxOw2BQJmBpkRBQkFo5qAAhsMAAoJEMfcncprxOw2N8ABAPcrkHouJPn2N8HcsL4S
 SVgqxNLVOpsMX9kAYgIMqM0WAQCA40v0iYH1q7QHa2IfgkrBzX2ZLdXdwoxfUr8EY5vtAg==
In-Reply-To: <87o6y5lvvg.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/3/25 23:36, Jonathan Corbet wrote:
> It would be best, of course, to get the memory-model documentation
> properly into our built docs...someday...

I hadn't thought about this. If this sentiment is shared by the LKMM
people I would be happy to work on this. Has this ever been
proposed/discussed before?

