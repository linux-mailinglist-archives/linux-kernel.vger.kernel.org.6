Return-Path: <linux-kernel+bounces-310562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09097967E64
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2DB1C21920
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9601814A0AB;
	Mon,  2 Sep 2024 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=it-x-os.net header.i=@it-x-os.net header.b="qztTG8ak"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1970320E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725250381; cv=none; b=gh6wsBiyumHzjCV3HPBRYy9qIGOE7UnpxUh1w+X2mnLPzGnlWHebLCXDKqQPHjJtc7CPZmmgqZMfT+i18oP0n7w7EsgHoDLCk8rk/jafBxu3L0Eri03bLxcBpuwm/cAMOFz6y8J+2zxtl1ro54gQ48C9duilyo3T2K6vmD9M+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725250381; c=relaxed/simple;
	bh=giT97lTnDKDZLDZ9bCgGxwbxHCiz+cAqH3ilycPUlY8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=u7ABLXM4/4uZ4GZ28JjYxHjOleH+xgcQ8Tvfcd2ugYUhfOVKBaEZBkQdRZ2IqOQRZoinxHujyZwR0lXxhuN0yXJ+6hBpEBP4q5UH29WitPxPY899J2qJNkyV/W4QlUy35+YpaxAMVEpgJ/Z9mq28sFczTsswoB6WW4WPd9B0Twk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=it-x-os.net; spf=pass smtp.mailfrom=it-x-os.net; dkim=pass (2048-bit key) header.d=it-x-os.net header.i=@it-x-os.net header.b=qztTG8ak; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=it-x-os.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-x-os.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=it-x-os.net
	; s=ds202408; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RwXRlvbZInpsElw+VwjIqZ/wNE/4e4vzKcRObOb9gOM=; b=qztTG8aknnfHbzFshnCvJDT0ZX
	IDh6y3dWtXJZmMOWbgWVoEm+ov+j3kIZDpihjydu247Tcj5PSFKAB2rsb+H6ANYooC0hyDWGU+P1M
	Gy23PbUiq5DRXNIW35Kq6eL0an+kvqkafrKqVU49pTl9l0z00sBZm47QbmBuDSotES1HfiQ3dK8r/
	mMpTzM9Ka1G0NBOxjMEHrhI4grYnzDUKiPHdrXVcpUzpkfNPko8+YZ9F6Cl4Q9gv6O73nw3rPNo97
	6x2A1DIbnDHX1Z1xv+QmUInrHZGR3jdaJvKHFdaGbWL2v6XxeUwCdKYFSJCj/3N9o1n8F9Rb+MWqr
	O7hh4L3w==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=64688)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe@it-x-os.net>)
	id 1skyQt-001JmW-Qe
	for linux-kernel@vger.kernel.org;
	Mon, 02 Sep 2024 06:12:51 +0200
Message-ID: <a09ec758-1a38-405a-a02f-8120cb9d1170@it-x-os.net>
Date: Mon, 2 Sep 2024 06:12:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Ywe@it-x-os.net>
Subject: IT x, handling of concepts of The God (was Fair Pay Philosophy, Low
 Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

IT as a concept also allegorizes related concepts of The God, such as 
Sin for mainboards, Sid for design, Tasin for games (I talked about 
these earlier). This will be correct for all catalogues in the system.

More: https://it-x-os.net/

Light.

