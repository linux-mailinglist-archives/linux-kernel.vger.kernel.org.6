Return-Path: <linux-kernel+bounces-320388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E26970981
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8871282CFD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A0178377;
	Sun,  8 Sep 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mh47LxjI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38E171658
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823903; cv=none; b=Xn0202lBq4ehs6K4gsz14SdcWeoAoPTeJsCwzmp4fByVa18T1EOU6DAt4/Wg97F/hHTGCbPWt8KH4Wxn9G5p5fRa2vJIzYeJkIGUXCWGDypqvze5vEBKlUVsLI6BM6CdbvgeRpCnoCTTwJwvqtH7Iolz7EP7sUZ+KPJYoi/2j/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823903; c=relaxed/simple;
	bh=UOihtH4yJ1kLHr5Rva6dNHZ/Fdk32dkRwJRPptenczI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXy1TW1z0rfpECOwuVsBztiueDFC3N1xH8ascqQ8w2vYFp7bTACk9RLYBIMy0kARsRFyPWjgwdej7JtGlRmPHbb5ePCtuDuf0xvVwHD/vCnPhPnnnjV0UN1Otq5FE/0D92fQpJs8vITsByRLyPMVJjMbQwCV8s9W+e4/cRbCOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=fail smtp.mailfrom=grimberg.me; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mh47LxjI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=grimberg.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UOihtH4yJ1kLHr5Rva6dNHZ/Fdk32dkRwJRPptenczI=; b=mh47LxjIrnTFzH7B1ZBPNNZigF
	BAHBTzqZIbhj96T1CE8NoTWg19CJm6R5JCfD0sLE+Vj5BCUFlZq+LguZzMVpIymNuq/8s1Y0wUxy+
	FUIZejKmUNknguUlKFr6qXjFQEw2qWo8rN/AxhZ422P+nO3mK/pSS/Kb8byL7fYdu1VTNUJrlP0/L
	Y6HLKX2PmU1hTWxkoGHSUJytDQX+NRYhzTGCg6c1RQzsGNas8v06IZzD65Eema4I+3G/BU6zIGdr8
	JeFh8TDbJub8bUKdmBUwUQQPngwLqnDtjvWJyloaTCaIOeu/EnbKoFa+65cwnDgT10vXqDK+RA7z9
	0UdRuWGQ==;
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.67])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snNdJ-0000000HLB3-2NUN;
	Sun, 08 Sep 2024 19:31:37 +0000
Message-ID: <d3c63cee-cf99-4191-a434-aa1d36879184@grimberg.me>
Date: Sun, 8 Sep 2024 22:31:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvme: Convert comma to semicolon
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240906065815.40300-1-shenlichuan@vivo.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906065815.40300-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Again (now will hopefully make it to the mailing list after some dns fixups)

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

