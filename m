Return-Path: <linux-kernel+bounces-435402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E29E7708
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD1028789B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0BB21AA0D;
	Fri,  6 Dec 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMbMu3HU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE39204580
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=jWa0sJ9VjCSYP6q1S0UjYl3Y/WPeBf0hM+HI48ujep7jHhi6t0ffaRFYiKg+76XXjFdMIsSvi0H5PNs9txigFTV3UqYwgH+qQkHouvDNHaoQa7NJIoB4UM1v4gdLAVrVAPMZxE1wKfmYiq1LcRbb2AJF4gqxQPXXH/96GwZzUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=gH9yBConPFlFAtM5yFnFIpjEGK22gESF+5Hl3wqFIsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDftnGE+qBFmJyMiYP4I3sla3p/KT3e8ITmCKVpI6fYKzZXeGAVoUnDnU12DF3C6BLlot0lbTEdo5EuZ1vaIQw8kPQdrPCsWdV2L56XKYxCHrnpJFlPeHQ10V2z2Nd7p3FwWprl0sOOfSYEu9hDqwZDFQGOYEQRmb972olny+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMbMu3HU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A0CC4AF0E;
	Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505688;
	bh=gH9yBConPFlFAtM5yFnFIpjEGK22gESF+5Hl3wqFIsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMbMu3HUDRY4XARuHPlMa3Y35tEDU7FqK84deiaamMnlDr9eY4bU9Pp+QxVG1cxts
	 91QoUvh3qgrHPiLUpxTBcY995K2vIm83brX7fkbzni+e2Eg7l3cJtdmW4b4171I7Im
	 S8wPr0FB1YMHko+pZBRQyCfXg4ohQFOzTTWuha2OXQtV5YlmDJM+mQqQWF004acFgp
	 6cMJZMuyKFXnD7RJS5XOSorifnbCKWC3GkehwUmLLWgBDbqTZPjXgX9FvPgrpokGFZ
	 HsaXXl9+pYxaLT64nRiC26LWEoTMYNaPaP21RKmVFvt83RKxHyKgN/C+/ElmPNuhdH
	 iiCS8Gp0g+8RA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc18-00000005RLG-0ui3;
	Fri, 06 Dec 2024 18:21:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 27/31] DEBUG
Date: Fri,  6 Dec 2024 18:12:49 +0100
Message-ID: <6f427a02c2c20512d5da178b47c64d553851a60e.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index abca351b18de..1fe4c536611a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -534,9 +534,11 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     ags = &acpi_ged_state->ghes_state;
 
     if (!ags->hest_lookup) {
+        fprintf(stderr,"Using old GHES lookup\n");
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
     } else {
+        fprintf(stderr,"Using new HEST lookup\n");
         get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
                                 &cper_addr, &read_ack_register_addr, errp);
     }
-- 
2.47.1


