Return-Path: <linux-kernel+bounces-296131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC20395A60D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2E11C20990
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981C16F27E;
	Wed, 21 Aug 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eclsXHrA"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931A1531CE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273221; cv=none; b=rjYuUJIJCd8QXDASsTH513WW1cSU+H7ztIkgtng204oa/dNdk9E7OF/aqSdyGMxcQ+RXCS9SiYkYVGSZCki0ykMnlu6JW/t4yIhYajF/MHVUEAhH7flPDbvS6C8xe8oz/4yoJuJsmGWEFY7vJIOyzWkWnXzeIcdiPZnqzLTKIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273221; c=relaxed/simple;
	bh=arXQVKhyWrh27oCxs4ybZWOEeYo+Z7D5PHkCjQfOR6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvDF7j4tkEywdZg+FBkh6/VQML8j4jsEKkMYYaOZg/CfJ5Q2MXR1ufPH6eMPHOrupl9ezvWRbjkPfbmV9C0aEN0s3iMEhggb26Foxt/qwEvoBYua6q2PafUFU6GaImHUElndOQmSDG0B/pNb0Nrk+onZYjed39T1eP7GUDGA2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eclsXHrA; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <12560207-6ed5-4a06-a69a-1feff5d4915a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724273217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arXQVKhyWrh27oCxs4ybZWOEeYo+Z7D5PHkCjQfOR6E=;
	b=eclsXHrAGWyQgltPf93pILXKvX5sNp0agMFJZLyyiv7BMvTq5PcqATDG2t8knOuXIaJa2b
	d5fp8YKS9k3makLfLVKCLauXZgGOrvkSz7Qx2wi/7HhpgWtIKGgZ5FfQ5B+nY60RpCUBCg
	zCH7SBe1evTbZKnxfsVRBfaxAYdOIP8=
Date: Wed, 21 Aug 2024 13:46:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] samples/bpf:Remove unused variables
Content-Language: en-GB
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, martin.lau@linux.dev
Cc: eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
 linux-kernel@vger.kernel.org
References: <20240820081737.5460-1-zhujun2@cmss.chinamobile.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240820081737.5460-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/20/24 1:17 AM, Zhu Jun wrote:
> The variable is never referenced in the code, just remove them
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


