Return-Path: <linux-kernel+bounces-169027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A179F8BC19C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EEA1F2150F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F50374DB;
	Sun,  5 May 2024 15:06:23 +0000 (UTC)
Received: from mail-a10.ithnet.com (mail-a10.ithnet.com [217.64.83.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D22D054
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.64.83.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714921582; cv=none; b=b5WZwvx3zCaDEcP5TXjznyfaGXMfu2YxT2kFc5TgRmoTQUxJXflUskvZzksBYasGkcSocYA5LSx4tbp8u5ZRHOJKBXEBMhmZajqhoqgImKAMEezBTOQDXUYhGxdInHDDXAeKfMfsa15YIfvffDJhxqltlYpyoD+/XvPeyil6OKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714921582; c=relaxed/simple;
	bh=ZsOlA4Ula7eMfe3y9ZuSDs6FAEB3mdrccODG8ln8fNk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=DLibqAzdPan5QsuMduHCX2h3/7FuI3bt7+VegcbmQQtdDbA/B1JBFy+pC+pSE69J2viQl6P3hYhR/kJ8GQBYplZzXiKDA2QOv+BbEWvv0GveStreUUzITIwtrO2adwlTsQY3jav8/pooM5X1jT5QiWoopa2yGkJeVqEEpUIchj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ithnet.com; spf=pass smtp.mailfrom=ithnet.com; arc=none smtp.client-ip=217.64.83.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ithnet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ithnet.com
Received: (qmail 15255 invoked by uid 0); 5 May 2024 14:59:35 -0000
Received: from skraw.ml@ithnet.com by mail-a10 
 (Processed in 1.962928 secs); 05 May 2024 14:59:35 -0000
X-Virus-Status: No
X-ExecutableContent: No
Received: from dialin014-sr.ithnet.com (HELO ithnet.com) (217.64.64.14)
  by mail-a10.ithnet.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 5 May 2024 14:59:33 -0000
X-Sender-Authentication: SMTP AUTH verified <skraw.ml@ithnet.com>
Date: Sun, 5 May 2024 16:59:32 +0200
From: Stephan von Krawczynski <skraw.ml@ithnet.com>
To: linux-kernel@vger.kernel.org
Subject: How to find out about a new peer connection in wireguard?
Message-ID: <20240505165932.5efba98e@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello all,

since I cannot find any information about this pretty simple question I
thought I present it to a broader audience here.
Can anyone tell how one can find out that a new peer connection was just made
to a wireguard interface?
It is obvious that the wireguard hooks like PostUP are useless because they
have no relation to peer connections at all.
So how is some admin informed about a new peer connection - equally about a
peer connection that just changed endpoint IP? Does the kernel give any hint
about that?
Please feel free to cc me in your answer, as else it may be hard to find for
me. Thank you!

-- 
Regards,
Stephan

