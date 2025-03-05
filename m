Return-Path: <linux-kernel+bounces-547907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E4A50F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDF73AF54E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34202209679;
	Wed,  5 Mar 2025 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcahj358"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C6206F0D;
	Wed,  5 Mar 2025 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215224; cv=none; b=ZBCOaP8KRpxCr9NwdzT22m6SUJx3sSqpGD2UAqja1KaJMLPnqeFp1UB7+T7z8nxBTTJC5Z8TVaMi9JHTfcrFXkP1Oqs8zwsfPtLxOAaKyH8aWW5wfEonCn31/pSCNV8LiK+koYDQ2Afi78Puu6Koy3JWQxXHJZV1jUjmUWnUTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215224; c=relaxed/simple;
	bh=IzEcyoCyWHi+rCICzxEDmfAQxlwMwW3cnneC+fHLMP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KaxvApAFlmy8VQlJKRxxXibhoqgb/XavFLEIrKNZmDoIO0cU9eNMZMf7fVoWBp4L7IKI5uE6wCASbjRwdJENdpDSh0YhMMWPNp8JkRn1CBhSyjh6y36MKQTi8hnxlaVaJnewGPoQme+myd4drIgTNGkNOHxHNDXb0xTG2PIQA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcahj358; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40E9C4CED1;
	Wed,  5 Mar 2025 22:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741215223;
	bh=IzEcyoCyWHi+rCICzxEDmfAQxlwMwW3cnneC+fHLMP8=;
	h=From:To:Cc:Subject:Date:From;
	b=hcahj358H6pUd6BxpLuiaSygaKcG2+wALNDwo+F+hzLcnoLrdGY+h4T4+3aISFkdi
	 nVzuEe0u12OlwxQBMTn5GO3PDragolu45trnfIka5PWdzg+TP0gHQn7XhCLet7cCuA
	 XfNJUaiRTcJxz3QYNItW31VlvLmdNysrlG9uigCc=
From: Shuah Khan <skhan@linuxfoundation.org>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] cpupower-monitor fix error legs and remove hard-codes 
Date: Wed,  5 Mar 2025 15:53:38 -0700
Message-ID: <20250305225342.19447-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two patch series fixes cpupower-monitor error legs to free cpu topology
and replaces hard-coded topology depth values with defines.

Shuah Khan (2):
  pm: cpupower: Fix cmd_monitor() error legs to free cpu_topology
  pm: cpupower: remove hard-coded topology depth values

 .../utils/idle_monitor/cpupower-monitor.c     | 42 ++++++++++++++-----
 1 file changed, 31 insertions(+), 11 deletions(-)

-- 
2.45.2


