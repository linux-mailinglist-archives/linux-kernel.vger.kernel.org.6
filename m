Return-Path: <linux-kernel+bounces-266432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D70393FFD7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A221F22D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AF189F33;
	Mon, 29 Jul 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="PTGNWGy9"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9183A19;
	Mon, 29 Jul 2024 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286429; cv=none; b=X5I2iulNk2eHEMCTjh3nrxcbS4coHti8LFsNai2YdC1EYWI5DsYtTl4MtahKXL5WWT/WmlRF7MNUo9I78hSONVmONcEmNSR3eQRBULabQ/pmtIGLAe5xL2GyalasvOh7SOhcjivzqJYUk7wzw0I2W8LRJd5Fh8nrgma9eC0VPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286429; c=relaxed/simple;
	bh=lGSceK6xn31FJ3zf9xU/X392prStJroN8J1VuxcxZfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeEKLFVFbXQjpBX8ZWIgBDS+EpWzZ45r0wor6C9KaDCVmxiOFFaexUYSiWTbTIHnxoR4V6udqYxWv1EoPZZGQxrnbojxmY+1IvqtcqS9igdSqVprlIzP6tIcWoQAH04T4lbIMyMR8QHFwxghGgsCVv+zwMhr6iJOoLTsc4Yniog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=PTGNWGy9; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=KVZXRm6p1am/1LxxJiqYVIeuHVLV72NEoIvpmSEr4hc=; b=PTGNWGy97StGsm6k
	6jB/TcqtcLmn93JuFY73evSv6QYVfWpsjY8wbq+tHNKqbLfY63hTw1MiJCRnjmtbjhUtpnLzNRaQc
	Mhnxl2AhCd87AZuI+fiImU+/nFTS0OrNsV7/Wkii9eBfqcOABL45mEggsVHjSdAl+Jc31Z6hQV1rw
	/Xc9b+66kToLwaOk6km5mAMqhXVMoEsbGI5tcu4UMwADlt1tgS2HYB70bWT3v4/uRhyg9EZIOSuWc
	ngKUWiHWmL/jYh5qzUA2xgRMjMqNg3dTXb7nzElXtb8d2pOHUrG5GsWcaysYTq2X/+3gos9E9Bec8
	ym8M/L+0EF5gqpc/fw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sYXNF-00DsLD-0f;
	Mon, 29 Jul 2024 20:53:41 +0000
From: linux@treblig.org
To: pabeni@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kennetkl@ifi.uio.no,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net/tcp: Expand goo.gl link
Date: Mon, 29 Jul 2024 21:53:37 +0100
Message-ID: <20240729205337.48058-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The goo.gl URL shortener is deprecated and is due to stop
expanding existing links in 2025.

Expand the link in Kconfig.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/ipv4/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 8e94ed7c56a0..6d2c97f8e9ef 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -661,7 +661,8 @@ config TCP_CONG_CDG
 
 	  For further details see:
 	    D.A. Hayes and G. Armitage. "Revisiting TCP congestion control using
-	    delay gradients." In Networking 2011. Preprint: http://goo.gl/No3vdg
+	    delay gradients." In Networking 2011. Preprint:
+	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-preprint.pdf
 
 config TCP_CONG_BBR
 	tristate "BBR TCP"
-- 
2.45.2


