Return-Path: <linux-kernel+bounces-529568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B56A427E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E9418822AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B5C26136C;
	Mon, 24 Feb 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1g4wRr4N"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12C262803
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414544; cv=none; b=dgynQvAvf6AkboApC8eRnnlCmAtn79eB/vjmB5UNtH5bpGFcpMsYovAnulfGI+hHQfoKwmIORbK8u3tWrJmz3xvhUxokLfE+EdcdVwh3uWN5WHudenjhs9+jBRPI+mInLqrM7QsUmZTXI0rvJTCJIplQgH+ZngZohBA0XMI8lJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414544; c=relaxed/simple;
	bh=j3TrfrMpQJ22Nm1x1LcioZGLbJMYiynWoTrsP7ZmVGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=polF8WhGp/gmx3Wcu8C/iTB4oAIiVdnfumAz9vtStoKjp80U/hKXfF1vR+H/lzE7bTJXoK8u6jKD1HS4Zwd5k8dLnougRP1sgn0hJ73hoNAsgeM6/l/kZSyoY/rG5HCKQqY+f8EKT8BLlaORmCWutmGIBbwDSN+dTAJisDPN+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1g4wRr4N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=d7fMW+I083qgX0CFhc+H3fYpKuYHmLO6abAgOmUyuFU=; b=1g4wRr4NoMr2ViE7u+fWdAT4GB
	I5EcbSyrWDU9FB7yohwOR2ezxYSfMfk85GDcoLVr6YVKLtXVZNhW6lSAfly6WhM2EpNFw3QiK0yjo
	cXqSMr3rMU9HuLXw51QeCDBFtS/m8YW7E+/ysJwl0DzmCB46JfIWh6i/KEB0aE1PUkjXx358NT5wP
	bEcpOEl4svSE09JhKnx5OeHN3XyFbQiytPckjJUBB7BFI+50xbcSRdHorscnLyqabWP2PLBpGc7kh
	M4pDyWkllr7IA/EjAHs2eSW658MfjY7+9/0jMG62JDBmyIXJfIhIqaxF4zwYQxDuMZNZXob2Q4vOt
	uy5uC0jg==;
Received: from syn-035-131-028-085.biz.spectrum.com ([35.131.28.85] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmbKH-0000000ESCU-3nSk;
	Mon, 24 Feb 2025 16:29:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: torvalds@linux-foundation.org
Cc: jlbec@evilplan.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] configfs: update MAINTAINERS
Date: Mon, 24 Feb 2025 08:28:59 -0800
Message-ID: <20250224162901.349933-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Joel will go back to maintain configfs alone on a time permitting basis.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5434da7a4889..a78eaaa24a69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5856,7 +5856,6 @@ F:	Documentation/security/snp-tdx-threat-model.rst
 
 CONFIGFS
 M:	Joel Becker <jlbec@evilplan.org>
-M:	Christoph Hellwig <hch@lst.de>
 S:	Supported
 T:	git git://git.infradead.org/users/hch/configfs.git
 F:	fs/configfs/
-- 
2.45.2


