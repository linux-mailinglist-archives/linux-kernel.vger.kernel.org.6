Return-Path: <linux-kernel+bounces-361456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785ED99A87E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842D21C2117D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE0198A30;
	Fri, 11 Oct 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferg.al header.i=@ferg.al header.b="UFUmGaI1"
Received: from mail.ferg.al (mail.ferg.al [128.140.123.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63644197A8B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.140.123.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662258; cv=none; b=OPHaoOKiYb/ha/Eg44NTzKPmuk/VwvDYlCkZWxIyltb8VOzYVu7edg0+WU4hBts9XvKbElqHa0o8uTJazgiiZc6BMaaql9Eay6pQeUBa9EcO7yQrp85dc1A2P+50p0+Si9iG0WOCG1DYYuLVPZtppwiWEktIT5Q/MZSJ3pSdfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662258; c=relaxed/simple;
	bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
	h=Date:From:To:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c3TvaSpmNb/dy+xABCx1e7+caZRSfkCJM6UR+EXEp68YQ9mnI01h+tY2z+SU/MRZf8qXPCyz9+9q0edZqlny1GyEhaX1VpDH8aNaOLZ5MJp3LV7d4gFVcB9pNbVH/nQVUpJA6TwYxAqy7DoPZ1hjcnS6tBRmT5RsYwnYHTk7vzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ferg.al; spf=pass smtp.mailfrom=ferg.al; dkim=pass (2048-bit key) header.d=ferg.al header.i=@ferg.al header.b=UFUmGaI1; arc=none smtp.client-ip=128.140.123.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ferg.al
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferg.al
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBB3FC6095
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:57:33 +0100 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ferg.al; s=dkim;
	t=1728662254; h=from:date:message-id:to:mime-version:content-type;
	bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
	b=UFUmGaI1LhG9XPDjz1uSC5ELFh5NIglkPevTxw1VT4X6gswKeQXl7Txi9eXvP7NQkHDpkb
	AsGoL0njblRGkN2Bcf8Gri7LB2ybwososxVxcV3E6Jb/zeLnQix9QD6EsdtGY8o0lBZZWb
	Ko5wVDnhO+WapRTdpmVEeQP4j8eXgCVl+S4FbjR+cqDI34DUviMPZ06jEe4TGhlMxVRF6n
	K+L1o6zLjFcieVa4al8ydd522jN1/rdk0NHi9Q6P5hi6b19+lI4rtDlSa4AFgkNUU4JHUP
	inFT5q5Wgi8mUlxuiBXJqn6FfrwkRhzSlyDhPBGiCgRX+2AyMDl807e6X1Mv0w==
Date: Fri, 11 Oct 2024 16:57:32 +0100
From: fergal <fergal@ferg.al>
To: linux-kernel@vger.kernel.org
Message-ID: <d2jvuc433rajaw24akeliwgxqoo27tlpgaumurbgxcii3bmucw@p4igi7vsmda7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

subscribe linux-kernel

