Return-Path: <linux-kernel+bounces-540919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA66A4B66E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20ED816A710
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2DF17C210;
	Mon,  3 Mar 2025 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8wh3aTQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06E7DA6D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740971834; cv=none; b=EsZaP2ue6HI/9z/UCWx2iAFNORITIgmVE9cSKxwlqub4KffDxNqhUJJMQNs/74qSoO+U424JPJWF4LXVR8zsCdec2VHd/8Mr7GxBqOmAGWFDvcNP18MBY0L8TgwjwFug3we6LMY67o0yOD1IInaJyUkHL8d1lGsXybXCLoYZQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740971834; c=relaxed/simple;
	bh=xU5JJtuoZOpfWjy3eZBFySpzJHmspTF01WDRNyO7QoM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EK5ch1CaMsxKg7EbhUXJMdKrb2Gdgn5ww5aVbByYNAVudowmv5pFTO7ly2UodL9N4aFPzrMce4zROKJu7rszcqjfh0kf5e6swMNr4+PSszgdiNVqJqpArzQIpPLCsywFCOLisKLguacr6X9U3jhk8jCedF50SZLNeBWUPYsYurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8wh3aTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C0AC4CED6;
	Mon,  3 Mar 2025 03:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740971834;
	bh=xU5JJtuoZOpfWjy3eZBFySpzJHmspTF01WDRNyO7QoM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Z8wh3aTQTZE3YLeJMJ3rsk+Y9ooPr5UGHrcsdC3XTaMS2W3mPzSkK+r+K2q0zkO2N
	 l0JXGgiM6nLCwnZGaQZozhBHnhThtKRTbw4mZJhQRE6fh3vF14ES1TYudE8oqz98gn
	 qu6FQKAqJHJ9abZgB6AQHFAFAudTt5D/Ap/uLN5ghbumNYALzOAl8S0SKUgk3aQWYF
	 GAcJ6RfCkULS3m22jnOEHRRlxBrnSIdtleg8LPQhvhmbnmRjmRvr9EbKA2IuuOD8XH
	 7pOWGNI/tRtixEwBCN6NxQXmHXJhE8XYUQZ6YtbczOuAG17EPk7Ilp7eMSxJLmG78D
	 S2X7HtGDaTgrQ==
Message-ID: <f5e744d2-02b1-4f6c-9467-b3925368b9a7@kernel.org>
Date: Mon, 3 Mar 2025 11:17:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs-tools: add ftruncate command in
 f2fs_io
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250228184752.1668252-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250228184752.1668252-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/25 02:47, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> add ftruncate command to do file truncate.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

