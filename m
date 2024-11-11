Return-Path: <linux-kernel+bounces-403677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BB19C38EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D3F28221F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368211581E5;
	Mon, 11 Nov 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WEN7gPGB"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1C4D8CB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309407; cv=none; b=c80DzMqu0B0XJdm95/FHH4tQNmdyCtvQviIYhbT7UzJ5aZrRh+KZvcdZJ6gDIExzLqL4M+OnfwQdaVU0S1a/NcL/QHzVZhe6QD5xkrtzBtAkLq3GNqmwORKl3sa5Q7rWpX5EykL5SJi5PHxFIQ975oSloUTgH1dPYDBLdsKjzqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309407; c=relaxed/simple;
	bh=Kn/k+z4zXvqlhPLrKC9C7JFoijQHJ+Nh/3TDsK4egdA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JJlCnhPYMYtZXb5LRoGfPyaBVumPaVyitdzN4qsPccvbiMq0+mOLtk87VK4RhA3ZfIBZjITM0XJqTwnqZ0IHR1hnlVtMgA1y5u38OFaol9hQFgPWA/96hxeQg14r0cv9JPnkTR0dupzxypqDbx9mZXSknkf7k8EJQwK4GEjVilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WEN7gPGB; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731309402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoTxF+maVAJZkqZIQYQC7KffSClcFIAhswoR2ph/hPY=;
	b=WEN7gPGBUXbNFHqZGYxBQsbIvvWdu/tlUkHuG7+END4f+tKMbhZeeqLtdSef18lt1Iy+re
	JmoSR2kyNiNJ1RCHX70XBHmgW5hofPs7kZ/VujzUOuY9qorEe205fKHPpNxGlNwcgrWzYf
	eqcPhG20exFWFNsCzY4rZmEMp1K0SqA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] powerpc: Transliterate author name and remove FIXME
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <87v7wuy3p5.fsf@mpe.ellerman.id.au>
Date: Mon, 11 Nov 2024 08:16:29 +0100
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8A9CA9F3-F780-4F2F-A5CE-8FE43463B84C@linux.dev>
References: <20241110162139.5179-2-thorsten.blum@linux.dev>
 <87v7wuy3p5.fsf@mpe.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
X-Migadu-Flow: FLOW_OUT

On 11. Nov 2024, at 02:11, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Thorsten Blum <thorsten.blum@linux.dev> writes:
>> The name is Mimi Phuong-Thao Vo.
> 
> Is that the correct spelling?

According to [1] it's correct.

Thanks,
Thorsten

[1] https://www.linkedin.com/in/mimi-phuong-thao-vo-5768033

