Return-Path: <linux-kernel+bounces-540208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2255A4AF72
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DC416BC45
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B415C1D5CC6;
	Sun,  2 Mar 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VGLBopo0"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC40E1C2DB2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897835; cv=none; b=SzMZAzLW6GfTOc/n6WnsgGJ30m2FQmDfRVm7cuUksiVRWQJoiA1OUv0Ig9WaAaZHFtOWaFjyhWGKvr+bTOJThX7caTmCfKNfdPE//MW/r7YTb4FSgbMiokhA6iIvU0DzJgZaWW9aP4p8pGeoKUaz7G2LkTQBapTsNlXmEgKru6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897835; c=relaxed/simple;
	bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=iKovZlZ5HAtbH1ugW4G5vwTtRWpEtSSgfcuzxvIlH8cUGGzLH6n0fIUUnTokaslxYTmY2nf1FywLk8dkTSF0jtvLs4jvSbq3/R9OBc/l9CP+CFeC0pz4xUyt9lQwHEvFgq0bT8dkO8oO3xz7XrKfkFla0AInncrtizQ43/kyYYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VGLBopo0; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=; b=VGLBopo
	0BcVGCb6hq2p3rw0y9Nrsi1hRj0yTcfAewRAkuo1L/ym1u3J+vU7acCN3A2FtFZM
	Cv2+YaE2NIF9sbMbA3QwlA6kFQLAWk6NXAt1mtdigqBNJF4mSZ4IuEuJT5csghDo
	qyRxs3pcTm4HH5Nx/cG2QsfhHorIy2xMh90A=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgD3D_ge_sNnY0JhBQ--.53149S2;
	Sun, 02 Mar 2025 14:43:42 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Typescript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PSkvCgD3D_ge_sNnY0JhBQ--.53149S2
Message-Id:<67C3FE1E.0B5A63.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaRpBUUUUU
Date: Sun, 2 Mar 2025 14:43:42 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhQEumfD7AnxrQAAsN

Hello! Rust is better than Typescript


